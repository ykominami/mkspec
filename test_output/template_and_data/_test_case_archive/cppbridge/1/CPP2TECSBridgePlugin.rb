# -*- coding: utf-8 -*-

#== C++ ⇒ TECS コンポーネントを生成するシグニチャプラグイン
class CPP2TECSBridgePlugin < SignaturePlugin

  CPPNamespace = :"nCPP"

  @@instances = {} # @signature => [ CPP2TECSBridgePlugin のインスタンスの配列 ]
  @@b_written = false # ファイル .i, .cpp, .hpp 出力済み
  @@celltypes = {}

  def initialize( signature, option )
    super
    signature.each_param do |func_decl, param_decl|
      case param_decl.get_direction
      when :INOUT, :OUT, :SEND, :RECEIVE
        Generator.error( "#{param_decl.get_direction.to_s.downcase} parameter cannot be used in Ruby Bridge" )
      end
    end
    @celltype_name = "t#{@signature.get_name}"
    @class_name = "C#{@signature.get_name}"
    if @@instances[signature] then
      @@instances[signature] << self
    else
      @@instances[signature] = [self]
    end

    if @@celltypes[@celltype_name] == nil then
      @@celltypes[@celltype_name] = [self]
      print_msg <<EOT
  CPP2TECSBridgePlugin: [signature] #{@signature.get_namespace_path} => [celltype] nCPP::#{@celltype_name} => [class] #{@class_name}
EOT

      TECSGEN::Makefile.add_var( "LD", "g++", "default Linker by CPP2TECSBridgePlugin")
      TECSGEN::Makefile.add_obj "$(_TECS_OBJ_DIR)#{@class_name}.o"
      TECSGEN::Makefile.add_line <<EOT

### added by CPP2TECSBridgePlugin (C++ -> TECS Bridge) ###

CPPC = g++
CPPFLAGS = $(CFLAGS)

# vpath for C++
vpath %.cpp $(SRC_DIR) $(GEN_DIR)

# generic target for C++
$(_TECS_OBJ_DIR)#{@class_name}.o : #{@class_name}.cpp\n	$(CPPC) -c $(CPPFLAGS) -o $@ $<

### end by CPP2TECSBridgePlugin ###
EOT
    else
      @@celltypes[@celltype_name] << self
    end

  end

  #===  CDL ファイルの生成
  #      typedef, signature, celltype, cell コードを生成
  #file::        FILE       生成するファイル
  def gen_cdl_file(file)

    # ブリッジセルタイプの生成
    file.print <<EOT
namespace #{CPPNamespace} {
  /// C++ => TECS bridge celltype ///
  [idx_is_id]
  celltype #{@celltype_name} {
    call #{@signature.get_name} cTECS;
  };
};
EOT

  end

  #file::        FILE       生成するファイル
  #===  受け口関数の postamble (C言語)を生成する
  def gen_postamble( file, b_singleton, ct_name, global_ct_name )

    # mikan namespace
    nsp0 = NamespacePath.new( CPPNamespace, true )
    nsp = nsp0.append ct_name
    ct = Namespace.find nsp
    gen_cpp ct
    gen_hpp ct
    if @@b_written == false then
      @@b_written = true
      @@instances.each do |signature, instances|
        nsp = nsp0.append instances[0].get_celltype_name.to_sym
        ct = Namespace.find nsp
      end
    end
  end

  def gen_cpp ct

    file = CFile.open( "#{$gen}/#{@class_name}.cpp", "w" )

    file.print <<EOT
/* This file is generated by CPP2TECSBridgePlugin */

#include  <stdlib.h>
#include  <memory.h>
#include  "t_stddef.h"
#include  "#{CPPNamespace}_#{@celltype_name}_tecsgen.h"
#include  "#{@class_name}.hpp"

EOT

    ct.get_cell_list.each do |cell|
      if cell.is_generate?
        file.print "char    CELL_#{cell.get_name}[] = \"#{cell.get_name}\";\n"
      end
    end

    file.print <<EOT
struct tagName2ID { char *name; ID id; } Name2ID[] = {
EOT
    ct.get_cell_list.each do |cell|
      if cell.is_generate?
        file.print "    { CELL_#{cell.get_name}, #{cell.get_id} },\n"
      end
    end

    file.print <<EOT
    { (char*)0, 0 }
};

#{@class_name} *
#{@class_name}::join( const char *CellName )
{
    int   i;
    for( i = 0; Name2ID[i].name; i++ )
        if( strcmp( CellName, Name2ID[i].name ) == 0 )
             break;

    if( ! Name2ID[i].name )
        return NULL;

	#{@class_name} *cell = new #{@class_name}( Name2ID[i].id, Name2ID[i].name );
	return cell;
}

#{@class_name}::#{@class_name}( ID id, const char *CellName )
{
    m_id = id;
    m_CellName = CellName;
}

EOT

    @signature.get_function_head_array.each do |fh| # fh: FuncHead
      fd = fh.get_declarator                 # fd: Decl (ここで fd が関数以外のことはない)
      ft = fd.get_type                       # ft: FuncType
      ret_type = ft.get_type

      # 関数頭部の出力
      file.printf( "%s\n%s::%s(",
                   ft.get_type_str,
                   @class_name,
                   fd.get_name )
      delim = ""
      ft.get_paramlist.get_items.each do |p| # p:  ParamDecl
        # size_is, count_is, string, send, receive には対応しない
        pd = p.get_declarator # pd: Decl
        file.printf( "%s %s %s%s",
                     delim,
                     pd.get_type.get_type_str,
                     pd.get_name,
                     pd.get_type.get_type_str_post )
        delim = ", "
      end
      file.print( " )\n{\n" )

      # 戻り値を記憶する変数の定義を出力
      if ret_type.get_original_type.kind_of? VoidType
        retval = ""
        retnul = ""
      elsif ret_type.get_type_str == "ER" || ret_type.get_type_str == "ER_UINT" then
        file.printf( "    %s    retval%s;\n", ft.get_type.get_type_str, ft.get_type.get_type_str_post )
        retval = "retval = "
        retnul = "E_ID"
      else
        file.printf( "    %s    retval%s;\n", ft.get_type.get_type_str, ft.get_type.get_type_str_post )
        retval = "retval = "
        retnul = "0"
      end

      file.print <<EOT
    if( ! VALID_IDX( m_id ) )
         return #{retnul};
    CELLCB *p_cellcb = (CELLCB*)GET_CELLCB( m_id );
EOT

      file.printf( "    %scTECS_%s( ", retval, fd.get_name )
      delim = ""
      ft.get_paramlist.get_items.each do |p| # p:  ParamDecl
        # size_is, count_is, string, send, receive には対応しない
        pd = p.get_declarator # pd: Decl
        file.printf( "%s%s", delim, pd.get_name )
        delim = ", "
      end
      file.print( " );\n" )
      if !ret_type.get_original_type.kind_of? VoidType
        file.print( "    return    retval;\n")
      end
      file.print( "}\n\n" )
    end

    file.close
  end

  def gen_hpp ct
    file = CFile.open( "#{$gen}/#{@class_name}.hpp", "w" )
    file.print <<EOT
/* This file is generated by CPP2TECSBridgePlugin */

EOT
    gen_class file
    file.close
  end

  def gen_class file
    file.print <<EOT
class #{@class_name} {
public:
    /*
     * join:  join to TECS cell.
     *
     * If CellName not found, NULL is returned.
     *
     * In 'join',  new #{@class_name}( ) is called.
     * So you have to delete after using the joined instance.
     */
    static #{@class_name} *join( const char *CellName );
EOT

    @signature.get_function_head_array.each do |fh| # fh: FuncHead
      fd = fh.get_declarator                 # fd: Decl (ここで fd が関数以外のことはない)
      ft = fd.get_type                       # ft: FuncType
      ret_type = ft.get_type

      # 関数頭部の出力
      file.printf( "    %s %s(",
                   ft.get_type_str,
                   fd.get_name )
      delim = ""
      ft.get_paramlist.get_items.each do |p| # p:  ParamDecl
        # size_is, count_is, string, send, receive には対応しない
        pd = p.get_declarator # pd: Decl
        file.printf( "%s %s %s%s",
                     delim,
                     pd.get_type.get_type_str,
                     pd.get_name,
                     pd.get_type.get_type_str_post )
        delim = ", "
      end
      file.print( " );\n" )
    end

    file.print <<EOT

private:
    #{@class_name}( ID id, const char *CellName );
    #{@class_name}();

    ID          m_id;
    const char  *m_CellName;
};

EOT
  end

  def get_celltype_name
    @celltype_name
  end

end
