<%
   /*���ƣ���������ָ��
�� * �汾: v1.0
�� * ����: 2009/3/7
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
 ��*/
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
	String opName = "���ò������·�ʱ���"; 
	ArrayList arrSession = (ArrayList)session.getAttribute("allArr");
	String[][] baseInfoSession = (String[][])arrSession.get(0);
	String[][] otherInfoSession = (String[][])arrSession.get(2);
	String regCode = (String)session.getAttribute("regCode");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String workName = baseInfoSession[0][3];
	String workNo = (String)session.getAttribute("workNo");
	String workPwd = (String)session.getAttribute("password");
	
	String StartTime =request.getParameter("StartTime")==null?"":request.getParameter("StartTime");
	String EndTime = request.getParameter("EndTime")==null?"":request.getParameter("EndTime");
	
	String op_name = "���ò������·�ʱ���";
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

%>



<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=gbk" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_util.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/common/common_check.js"></script>
<script type="text/javascript"  src="<%=request.getContextPath()%>/js/rpc/src/core_c.js"></script>


<script language="javascript">
	//����Ӧ��ȫ�ֵı���
    var SUCC_CODE   = "0";          //�Լ�Ӧ�ó�����
    var ERROR_CODE  = "1";          //�Լ�Ӧ�ó�����
    var YE_SUCC_CODE = "0000";      //����Ӫҵϵͳ������޸�
    var dynTbIndex=1;               //���ڶ�̬�����ݵ�����λ��,��ʼֵΪ1.���Ǳ�ͷ

    var oprType_Add = "a";
    var oprType_Upd = "u";
    var oprType_Del = "d";
    var oprType_Qry = "q";

    var TOKEN="|";
  onload=function(){
  	
  	 var stime="<%=StartTime%>";
  	 var etime="<%=EndTime%>";  	 
  	if(stime!=""&&etime!=""){
  			var starr = new Array();
				var etarr = new Array();
				starr=stime.split("|");
				etarr=etime.split("|");
				for(var a=0; a< starr.length-1 ;a++)
				{
					queryAddAllRow(0,starr[a],etarr[a]);
				}
  	}
  }  
	function call_ADDCode()
	{
		 //alert("0");
		 if(!validTime(document.form1.StartTime)) return false;
		 if(!validTime(document.form1.EndTime)) return false;
		 //wuxy alter 20090518 ������ҵ���ز಻֧�ֿ���ʱ��δ����Ӵ�����
		 if ( document.all.EndTime.value < document.all.StartTime.value )
    	{
       	 	rdShowMessageDialog("����ʱ�䲻��С�ڿ�ʼʱ�䣬ʱ������ò��������!");
        	return false;
    	}

		 
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
       	 	rdShowMessageDialog("�������4��ʱ��� !!");
        	return false;
    	}

      tmp_flag = verifyUnique(typeflag,StartTime,EndTime);
      if(tmp_flag == false)
      {
        rdShowMessageDialog("�Ѿ���һ����ͬ��ָ��,ָ�����ݺ�Ŀ�ĺ��벻�����ظ�!");
        return false;
      }
      
      tr1=dyntb.insertRow();    //ע�⣺����ı������������һ��,������ɿ���.yl.
      tr1.id="tr"+dynTbIndex;
		//alert("3");
      tr1.insertCell().innerHTML = '<div align="center"><input id=R0    type=checkBox    size=4 value="ɾ��" onClick="dynDelRow()" ></input></div>';
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


        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
        {
              tmp_StartTime = document.all.R1[a].value;
              tmp_EndTime = document.all.R2[a].value;
              



            if( op_type == oprType_Add)
            {
              
              if( (jtrim(StartTime) == jtrim(tmp_StartTime))
                && (jtrim(EndTime) == jtrim(tmp_EndTime))
           
              ){
                    return false;
                }
              
            }

        }

           return true;
    }
    function dynDelRow()
    {

        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
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
        //������ӱ��е�����
        for(var a = document.all.dyntb.rows.length-2 ;a>0; a--)//ɾ����tr1��ʼ��Ϊ������
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
            rdShowMessageDialog("��ѯ����ȷ��!");
            return false;
        }

			if( dyntb.rows.length == 2){//������û������
				rdShowMessageDialog("������û������,����������!!");
				return false;
				}else{
				for(var a=1; a<document.all.R0.length ;a++)//ɾ����tr1��ʼ��Ϊ������
				{
					ind1Str =ind1Str +document.all.R1[a].value+"|";
					ind2Str =ind2Str +document.all.R2[a].value+"|";
					ind3Str= ind3Str+document.all.R1[a].value+"|"+document.all.R2[a].value+"|";
					
				}
			}
		

        //2.��form�������ֶθ�ֵ

        window.opener.form1.StartTime.value = ind1Str;
        window.opener.form1.EndTime.value = ind2Str;
        
        window.opener.form1.InvalidTimeSpanList.value=ind3Str;
        window.close();
    }
    
	
	
</script>

</head> 

<body >

<form name="form1" method="post" action="">	
<%@ include file="/npage/include/header_pop.jsp" %>

<div id="Operation_Table">

	<TABLE width="100%" border=0 align="center" cellSpacing=1.5>
			<TR id="line_1"> 
				<TD colspan="4" class="blue" ><strong>���ò������·�ʱ��Σ�(ʱ���֮�䲻���н���Ͱ�������ʽΪHHMISS������24Сʱ�� )</strong></TD>	            						    		            	              
	         </TR> 	
	         <TR  id="line_1">
             	<TD class="blue" >�������·���ʼʱ�䣺</TD>
	            <TD >
	              	<input type="text" name="StartTime" v_type="time" v_format="HHMISS" v_must="1"  v_maxlength="6" v_name="�������·���ʼʱ��" maxlength="6" >
	            </TD> 
							<TD class="blue" >�������·�����ʱ�䣺</TD>
	            <TD >
	              		<input type="text" name="EndTime" v_type="time"  v_format="HHMISS" v_must="1"  v_maxlength="6" v_name="�������·�����ʱ��" maxlength="6" >
	            	<input name="addCode" type="button" class="b_text" value="����" onClick="call_ADDCode()">
	            </TD> 	         								    		            	              
	         </TR>  
	         
	          
	         <tr >
            <td colspan="6" >
              <table width="98%" border="1" id="dyntb">
                <tr>
                  <td align="center" nowrap class="blue" >ɾ������</td>
                  
                  <td align="center" class="blue" >�������·���ʼʱ��</td>
                  <td align="center" class="blue" >�������·�����ʱ��</td>
                  
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
	        <TABLE id="tabAddBtn1" style="display:''"  width="100%" border=0 align="center" cellSpacing=0 bgcolor="#F5F5F5">
	    	<tr bgcolor="#F5F5F5">
            <td colspan="6">
              <div align="center"> &nbsp;
                <input name="confirm" style="cursor:hand" type="button" class="b_foot" value="ȷ��" onClick="commitJsp()">
                &nbsp;
                <input name="reset" style="cursor:hand" type="button" class="b_foot" value="���" onClick="resetJsp()">
                &nbsp;
                <input name="back" style="cursor:hand" onClick="parent.window.close()" type="button" class="b_foot" value="�ر�">
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