<%
   /*名称：设置上行指令
　 * 版本: v1.0
　 * 日期: 2009/3/7
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html;charset=gbk"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.sitech.crmpd.core.wtc.util.*" %>

<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	String opName = "设置上行指令";  
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String regCode = (String)session.getAttribute("regCode");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String workName = baseInfoSession[0][3];
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	
	String moype =request.getParameter("MOType")==null?"":request.getParameter("MOType");
	String mocode = request.getParameter("MOCode")==null?"":request.getParameter("MOCode");
	String destservcode =request.getParameter("DestServCode")==null?"":request.getParameter("DestServCode");
	String codemathmode = request.getParameter("CodeMathMode")==null?"":request.getParameter("CodeMathMode");
	String servcodemathmode =request.getParameter("ServCodeMathMode")==null?"":request.getParameter("ServCodeMathMode");

	String op_name = "设置上行指令";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

%>



<html>
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gb2312" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>
<link rel="stylesheet" href="../../css/style.css" type="text/css">

<script language="javascript">
	//定义应用全局的变量
    var SUCC_CODE   = "0";          //自己应用程序定义
    var ERROR_CODE  = "1";          //自己应用程序定义
    var YE_SUCC_CODE = "0000";      //根据营业系统定义而修改
    var dynTbIndex=1;               //用于动态表数据的索引位置,开始值为1.考虑表头

    var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";

    var TOKEN="|";
    onload=function(){
  	
  	 var moype="<%=moype%>";
  	 var mocode="<%=mocode%>";  
  	 var destservcode="<%=destservcode%>";
  	 var codemathmode="<%=codemathmode%>";
  	 var servcodemathmode="<%=servcodemathmode%>"; 
  	if(moype!=""&&mocode!=""){
  			var moypearr = new Array();
				var mocodarr = new Array();
				var destarr = new Array();
				var codearr = new Array();
				var servarr = new Array();
				moypearr=moype.split("|");
				mocodarr=mocode.split("|");
				destarr=destservcode.split("|");
				codearr=codemathmode.split("|");
				servarr=servcodemathmode.split("|");
		
				for(var a=0; a< moypearr.length-1 ;a++)
				{			
					queryAddAllRow(0,moypearr[a],mocodarr[a],destarr[a],codearr[a],servarr[a]);
				}
  	}
  }   
	function call_ADDCode()
	{
		 //alert("0");
		 if(!checkElement("MOCode")) return false;
		 if(!checkElement("DestServCode")) return false;
		 
		 //只做简单校验
		 if(document.all.MOCode.value.substring(0,4)=="0000"||
		    document.all.MOCode.value.substring(0,4)=="1111"||
		    document.all.MOCode.value.substring(0,4)=="HELP")
		 {
		 	rdShowMessageDialog("指令内容前四位不允许为输入内容，字母不区分大小写！");
			return false;
		 }
		 if(document.all.MOCode.value.substring(0,2)=="CX"||
		 	document.all.MOCode.value.substring(0,3)=="SIM")
		 {
		 	rdShowMessageDialog("指令内容不能以‘CX’或‘SIM’开头,不区分大小写！");
			return false;
		 }
		 if(document.all.MOCode.value.substring(0,5)=="000000")
		 {
		 	rdShowMessageDialog("指令内容不能以连续5个0为开头！");
			return false;
		 }
		 //alert("1");
         dynAddRow();
	}
	
	function dynAddRow()
    {
        var basecode_type="";
        var basecode="";
        var descode="";
        var CodeMathMode="";
        var ServCodeMathMode="";
        var tmpStr="";
        var flag=false;
        var op_type = oprType_Add;
        if( op_type == oprType_Add)
        {
          basecode_type = document.all.MOType.value;
          basecode = document.all.MOCode.value;
          descode= document.all.DestServCode.value;
          CodeMathMode=document.all.CodeMathMode.value;
          //alert("CodeMathMode="+CodeMathMode);
          ServCodeMathMode=document.all.ServCodeMathMode.value;
          //alert("ServCodeMathMode="+ServCodeMathMode);
          if(!checkElement("MOCode")) return false;
          if(!checkElement("DestServCode")) return false;
        }
        //alert("2");
      queryAddAllRow(0,basecode_type,basecode,descode,CodeMathMode,ServCodeMathMode);
    }
    
    function queryAddAllRow(add_type,basecode_type,basecode,descode,CodeMathMode,ServCodeMathMode)
    {
    	var tr1="";
    	var i=0;
    	var tmp_flag=false;
    	var typeflag="";
    	var typeflag1="";
    	var typeflag2="";
    	//alert(CodeMathMode);
    	//alert(ServCodeMathMode);
    	
    	if(basecode_type==0)
    	{
    		typeflag="点播指令";		
    	}
    	else if(basecode_type==1)
    	{
    		typeflag="订购指令";
    	}
    	else if(basecode_type==2)
    	{
    		typeflag="退订指令";
    	}
    	else if(basecode_type==3)
    	{
    		typeflag="查询指令";
    	}
    	else if(basecode_type==4)
    	{
    		typeflag="透传指令";
    	}
    	
    	if(CodeMathMode==0)
    	{
    		typeflag1="全匹配";
    	}
    	else
    	{
    		typeflag1="前缀匹配";
    	}
    	
    	if(ServCodeMathMode==0)
    	{
    		typeflag2="全匹配";
    	}
    	else
    	{
    		typeflag2="前缀匹配";
    	}

    	var exec_status="";
    	if ( parseInt(document.all.addRecordNum.value) > 5 )
    	{
       	 	rdShowMessageDialog("最多只能有5条指令 !!");
        	return false;
    	}

      tmp_flag = verifyUnique(typeflag,basecode,descode);
      if(tmp_flag == false)
      {
        rdShowMessageDialog("已经有一条相同的指令,指令内容和目的号码不允许重复!");
        return false;
      }
      
      tr1=dyntb.insertRow();    //注意：插入的必须与下面的在一起,否则造成空行.yl.
      tr1.id="tr"+dynTbIndex;
		//alert("3");
      tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox    size=4 value="删除" onClick="dynDelRow()" ></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text   size=10 value="'+ typeflag+'"  readonly></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text   value="'+ basecode+'"  readonly></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R3    type=text   value="'+ descode+'"  readonly></input></div>';    
      tr1.insertCell().innerHTML = '<div align="center"><input id=R4    type=text   value="'+ typeflag1+'"  readonly></input></div>';    
      tr1.insertCell().innerHTML = '<div align="center"><input id=R5    type=text   value="'+ typeflag2+'"  readonly></input></div>';    
      tr1.insertCell().innerHTML = '<div align="center"><input id=R6    type=hidden   value="'+ basecode_type+'"  readonly></input></div>';    
      tr1.insertCell().innerHTML = '<div align="center"><input id=R7    type=hidden   value="'+ CodeMathMode+'"  readonly></input></div>';    
      tr1.insertCell().innerHTML = '<div align="center"><input id=R8    type=hidden   value="'+ ServCodeMathMode+'"  readonly></input></div>';    
      
      dynTbIndex++;
      document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }
    
    function verifyUnique(basecode_type,basecode,descode)
    {
        var tmp_basecode_type="";
        var tmp_basecode="";
        var tmp_descode="";
      
        var op_type = oprType_Add;


        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
              tmp_basecode_type = document.all.R1[a].value;
              tmp_basecode = document.all.R2[a].value;
              tmp_descode = document.all.R3[a].value;



            if( op_type == oprType_Add)
            {
              if((jtrim(basecode_type) == jtrim(tmp_basecode_type))
              ){
              	return false;
              }
              if( (jtrim(basecode_type) == jtrim(tmp_basecode_type))
                && (jtrim(basecode) == jtrim(tmp_basecode))
                && (jtrim(descode) == jtrim(tmp_descode))
              ){
                    return false;
                }
              if((jtrim(basecode) == jtrim(tmp_basecode))
                 && (jtrim(descode) == jtrim(tmp_descode))
              ){
              	return false;
               }
            }

        }

           return true;
    }
    function dynDelRow()
    {

        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
            if(document.all.R0[a].checked == true)
            {
                document.all.dyntb.deleteRow(a+1);
                break;
            }
        }
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;

    }
    function dyn_deleteAll()
    {
        //清除增加表中的数据
        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
                document.all.dyntb.deleteRow(a+1);
        }
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }
    
    function init()
    {
		
        
		document.all.MOCode.value="";
		document.all.DestServCode.value="";
        document.all.addRecordNum.value = document.all.dyntb.rows.length-2;

        
    }
    function resetJsp()
    {
    
    var op_type = oprType_Add;

        init();

     
        dyn_deleteAll();
        reset_globalVar();

    }
    function reset_globalVar()
    {
      dynTbIndex=1;
    }
    function commitJsp()
    {
        var ind1Str ="";
        var ind2Str ="";
        var ind3Str ="";
        var ind4Str ="";
        var ind5Str ="";

        var tmpStr="";
        

        var op_type = oprType_Add;

        var procSql = "";

        if( op_type == oprType_Qry )
        {
            rdShowMessageDialog("查询不能确认!");
            return false;
        }

			if( dyntb.rows.length == 2){//缓冲区没有数据
				rdShowMessageDialog("缓冲区没有数据,请增加数据!!");
				return false;
				}else{
				for(var a=1; a<document.all.R0.length ;a++)//删除从tr1开始，为第三行
				{
					ind1Str =ind1Str +document.all.R6[a].value+"|";
					ind2Str =ind2Str +document.all.R2[a].value+"|";
					ind3Str =ind3Str +document.all.R3[a].value+"|";
					ind4Str =ind4Str +document.all.R7[a].value+"|";
					ind5Str =ind5Str +document.all.R8[a].value+"|";
				}
			}
		

        //2.对form的隐含字段赋值

        window.opener.form1.MOType.value = ind1Str;
        window.opener.form1.MOCode.value = ind2Str;
        window.opener.form1.DestServCode.value = ind3Str;
        window.opener.form1.CodeMathMode.value = ind4Str;
        window.opener.form1.ServCodeMathMode.value = ind5Str;
        window.opener.form1.MOList.value=window.opener.form1.MOCode.value;
        window.close();
    }
    
	
	
</script>

</head> 

<body >

<form name="form1" method="post" action="">	

<%@ include file="/npage/include/header_pop.jsp" %>

<div id="Operation_Table">

	<TABLE width="100%" border=0 align="center" cellSpacing=1.5 >
			<TR   id="line_1"> 
				<TD colspan="4" class="blue" ><strong>设置上行指令：(指令内容不能以如下字符开头：SIM、0000、00000、11111、CX、HELP以及0、1等三位以内的数字，字母不区分大小写)</strong></TD>	            						    		            	              
	         </TR> 	
	         <TR   id="line_1">
             	<TD class="blue"   >指令内容：</TD>
	            <TD   >
	              	<input type="text" name="MOCode"  v_type="string" v_must="1" v_minlength="1" v_maxlength="10" v_name="指令内容" maxlength="10" >
	            </TD> 
							<TD class="blue"  >指令内容匹配方式：</TD>
	            <TD   >
	              	<select name="CodeMathMode" style="width:133px;">
          					<option value='0'>全匹配</option>
          					<option value='1'>前缀匹配</option>
	              	</select>
	            </TD> 	         								    		            	              
	         </TR>  
	         <TR   id="line_1">
             	<TD class="blue"  >指令类型：</TD>
	            <TD  >
	              	<select name="MOType" style="width:133px;">
          					<option value='0'>点播指令</option>
          					<option value='1'>订购指令</option>
          					<option value='2'>退订指令</option>
          					<option value='3'>查询指令</option>
          					<option value='4'>透传指令</option>
	              	</select>
	            </TD> 
							<TD class="blue"  >目的号码：</TD>
	            <TD   >
	              	<input type="text" name="DestServCode"  v_type="string" v_must="1" v_minlength="1" v_maxlength="21" v_name="目的号码" maxlength="21" >
	            </TD> 	         								    		            	              
	         </TR>  
	         <TR   id="line_1">
             	<TD class="blue"  >目的号码匹配方式：</TD>
	            <TD  colspan="2"  >
	              	<select name="ServCodeMathMode" style="width:133px;">
          					<option value='0'>全匹配</option>
          					<option value='1'>前缀匹配</option>
	              	</select>
	            </TD> 
				<td width="20%"  height = 20  >
            	<input name="addCode" type="button" class="b_text" value="增加" onClick="call_ADDCode()">
             </td>			
	                  								    		            	              
	         </TR>  
	         <tr  >
            <td colspan="6"  >
              <table width="98%" border="1" id="dyntb">
                <tr>
                  <td align="center" nowrap>删除操作</td>
                  
                  <td align="center">指令类型</td>
                  <td align="center">指令内容</td>
                  <td align="center">目的号码</td>
                  <td align="center">指令内容匹配方式</td>
                  <td align="center">目的号码匹配方式</td>
                  
                </tr>
	         <tr id="tr0" style="display:none">
	         	 <input type="hidden" id="R6" value="">
	         	 <input type="hidden" id="R7" value="">
	         	 <input type="hidden" id="R8" value="">
                  <td>
                    <div align="center">
                      <input type="checkBox" id="R0" value="">
                    </div>
                  </td>
                  <td>
                    <div align="center">
                      <input type="text" id="R1" value="">
                    </div>
                  </td>
                  <td>
                    <div align="center">
                      <input type="text" id="R2" value="">
                    </div>
                  </td>
                  <td>
                    <div align="center">
                      <input type="text" id="R3" value="">
                    </div>
                  </td>
                  <td>
                    <div align="center">
                      <input type="text" id="R4" value="">
                    </div>
                  </td>
                  <td>
                    <div align="center">
                      <input type="text" id="R5" value="">
                    </div>
                  </td>
                 </tr>
	        </TABLE>    
	        <TABLE id="tabAddBtn1" style="display:''"  width="100%" border=0 align="center" cellSpacing=0  >
	    	<tr  >
            <td colspan="6">
              <div align="center"> &nbsp;
                <input name="confirm" style="cursor:hand" type="button"  class="b_foot" value="确认" onClick="commitJsp()">
                &nbsp;
                <input name="reset" style="cursor:hand" type="button"  class="b_foot" value="清除" onClick="resetJsp()">
                &nbsp;
                <input name="back" style="cursor:hand" onClick="parent.window.close()" type="button"  class="b_foot" value="关闭">
                &nbsp; </div>
            </td>
          </tr>
	    	
	    </TABLE>
	    <input type="hidden" name="addRecordNum" type="text" class="button" id="addRecordNum" value="" size=7 readonly>
	    
	    </div>
	    <%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>    