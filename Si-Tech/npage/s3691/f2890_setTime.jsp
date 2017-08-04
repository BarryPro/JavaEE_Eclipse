<%
   /*名称：设置上行指令
　 * 版本: v1.0
　 * 日期: 2009/3/7
　 * 作者: wuxy
　 * 版权: sitech
   * 修改历史
   * 修改日期      修改人      修改目的
   * 2009-03-18     qidp       修改样式
 　*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType= "text/html;charset=GBK" %>
<%@ page import="java.text.SimpleDateFormat"%>
<%
	ArrayList retArray = new ArrayList();
	String[][] result = new String[][]{};
	 
	String workName = (String)session.getAttribute("workName");
	String orgCode = (String)session.getAttribute("orgCode");
	String workNo = (String)session.getAttribute("workNo");
	String ip_Addr = (String)session.getAttribute("ipAddr");
	String regionCode = orgCode.substring(0,2);
	
	String nopass  = (String)session.getAttribute("password");
	
	String op_name = "设置不允许下发时间段";
	String opName = op_name;
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script>
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
    
	function call_ADDCode()
	{
		 //alert("0");
		 if(!forDate(document.form1.StartTime)) return false;
		 if(!forDate(document.form1.EndTime)) return false;

		 
         dynAddRow();
	}
	
	function dynAddRow()
    {
        var StartTime="";
        var EndTime="";
        
        var tmpStr="";
        var flag=false;
        var op_type = oprType_Add;
        if( op_type == oprType_Add)
        {
          StartTime = document.all.StartTime.value;
          EndTime = document.all.EndTime.value;
          
        }
        //alert("2");
      queryAddAllRow(0,StartTime,EndTime);
    }
    
    function queryAddAllRow(add_type,StartTime,EndTime)
    {
    	var tr1="";
    	var i=0;
    	var tmp_flag=false;
    	var typeflag="";

    	var exec_status="";
    	if ( parseInt(document.all.addRecordNum.value) > 4 )
    	{
       	 	rdShowMessageDialog("最多设置4个时间段 !!");
        	return false;
    	}

      tmp_flag = verifyUnique(typeflag,StartTime,EndTime);
      if(tmp_flag == false)
      {
        rdShowMessageDialog("已经有一条相同的指令,指令内容和目的号码不允许重复!");
        return false;
      }
      
      tr1=dyntb.insertRow();    //注意：插入的必须与下面的在一起,否则造成空行.yl.
      tr1.id="tr"+dynTbIndex;
		//alert("3");
      tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox    size=4 value="删除" onClick="dynDelRow()" ></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R1    type=text   size=10 value="'+ StartTime+'"  readonly></input></div>';
      tr1.insertCell().innerHTML = '<div align="center"><input id=R2    type=text   value="'+ EndTime+'"  readonly></input></div>';
      
      
      dynTbIndex++;
      document.all.addRecordNum.value = document.all.dyntb.rows.length-2;
    }
    
    function verifyUnique(basecode_type,StartTime,EndTime)
    {
        var tmp_StartTime="";
        var tmp_EndTime="";
       
      
        var op_type = oprType_Add;


        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//删除从tr1开始，为第三行
        {
              tmp_StartTime = document.all.R1[a].value;
              tmp_EndTime = document.all.R2[a].value;
              



            if( op_type == oprType_Add)
            {
              
              if( ((StartTime.trim()) == (tmp_StartTime.trim()))
                && ((EndTime.trim()) == (tmp_EndTime.trim()))
           
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
					ind1Str =ind1Str +document.all.R1[a].value+"|";
					ind2Str =ind2Str +document.all.R2[a].value+"|";
					ind3Str= ind3Str+document.all.R1[a].value+"|"+document.all.R2[a].value+"|";
					
				}
			}
		

        //2.对form的隐含字段赋值

        window.opener.document.frm.StartTime.value = ind1Str;
        window.opener.document.frm.EndTime.value = ind2Str;
        window.opener.document.frm.F00020.value=ind3Str;
        
        window.close();
    }
    
	
	
</script>

</head> 

<body>

<form name="form1" method="post" action="">	
<%@ include file="/npage/include/header_pop.jsp" %>
<div class="title">
	<div id="title_zi"><%=opName%></div>
</div>
	<TABLE cellSpacing=0>
			<TR id="line_1"> 
				<TD colspan="4" class="orange"><strong>设置不允许下发时间段(时间段之间不能有交叉和包含，格式为HHmmss，采用24小时制 )</strong></TD>	            						    		            	              
	         </TR> 	
	         <TR id="line_1">
             	<TD class=blue>不允许下发开始时间</TD>
	            <TD>
	              	<input type="text" name="StartTime" v_type="time" v_format="HHmmss" v_must="1"  v_maxlength="6" maxlength="6" >
	            </TD> 
							<TD class=blue>不允许下发结束时间</TD>
	            <TD>
	              		<input type="text" name="EndTime" v_type="time"  v_format="HHmmss" v_must="1"  v_maxlength="6" maxlength="6" >
	            	<input name="addCode" type="button" class="b_text" value="增加" onClick="call_ADDCode()">
	            </TD> 	         								    		            	              
	         </TR>  
	        </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">结果列表</div>
</div>

              <table id="dyntb" cellSpacing=0>
                <tr align=center>
                  <th nowrap>删除操作</th>
                  
                  <th>不允许下发开始时间</th>
                  <th>不允许下发结束时间</th>
                  
                </tr>
	         <tr id="tr0" style="display:none">
	         	 
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
                  
                 </tr>
	        </TABLE>    
	        <TABLE id="tabAddBtn1" style="display:" cellSpacing=0>
	    	<tr id=footer>
            <td colspan="6">
                <input name="confirm" type="button" class="b_foot" value="确认" onClick="commitJsp()">
                <input name="reset" type="button" class="b_foot" value="清除" onClick="resetJsp()">
                <input name="back" onClick="parent.window.close()" type="button" class="b_foot" value="关闭">
            </td>
          </tr>
	    	
	    </TABLE>
	    <input type="hidden" name="addRecordNum" type="text" class="button" id="addRecordNum" value="" size=7 readonly>
	    
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>    
