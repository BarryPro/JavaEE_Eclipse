<%
   /*���ƣ���������ָ��
�� * �汾: v1.0
�� * ����: 2009/3/7
�� * ����: wuxy
�� * ��Ȩ: sitech
   * �޸���ʷ
   * �޸�����      �޸���      �޸�Ŀ��
   * 2009-03-18     qidp       �޸���ʽ
 ��*/
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
	
	String op_name = "���ò������·�ʱ���";
	String opName = op_name;
	
	String strDate = new SimpleDateFormat("yyyyMMdd").format(new Date());

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=op_name%></title>
<META content="text/html; charset=GBK" http-equiv=Content-Type>
<meta http-equiv="Expires" content="0">

<script>
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
				<TD colspan="4" class="orange"><strong>���ò������·�ʱ���(ʱ���֮�䲻���н���Ͱ�������ʽΪHHmmss������24Сʱ�� )</strong></TD>	            						    		            	              
	         </TR> 	
	         <TR id="line_1">
             	<TD class=blue>�������·���ʼʱ��</TD>
	            <TD>
	              	<input type="text" name="StartTime" v_type="time" v_format="HHmmss" v_must="1"  v_maxlength="6" maxlength="6" >
	            </TD> 
							<TD class=blue>�������·�����ʱ��</TD>
	            <TD>
	              		<input type="text" name="EndTime" v_type="time"  v_format="HHmmss" v_must="1"  v_maxlength="6" maxlength="6" >
	            	<input name="addCode" type="button" class="b_text" value="����" onClick="call_ADDCode()">
	            </TD> 	         								    		            	              
	         </TR>  
	        </table>
</div>
<div id="Operation_Table">
<div class="title">
	<div id="title_zi">����б�</div>
</div>

              <table id="dyntb" cellSpacing=0>
                <tr align=center>
                  <th nowrap>ɾ������</th>
                  
                  <th>�������·���ʼʱ��</th>
                  <th>�������·�����ʱ��</th>
                  
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
                <input name="confirm" type="button" class="b_foot" value="ȷ��" onClick="commitJsp()">
                <input name="reset" type="button" class="b_foot" value="���" onClick="resetJsp()">
                <input name="back" onClick="parent.window.close()" type="button" class="b_foot" value="�ر�">
            </td>
          </tr>
	    	
	    </TABLE>
	    <input type="hidden" name="addRecordNum" type="text" class="button" id="addRecordNum" value="" size=7 readonly>
	    
<%@ include file="/npage/include/footer_pop.jsp" %>
</form>
</body>
</html>    
