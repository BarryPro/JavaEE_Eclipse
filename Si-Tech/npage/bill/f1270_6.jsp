<%
/********************
 version v2.0
������: si-tech
*
*update:zhanghonga@2008-08-19 ҳ�����,�޸���ʽ
*
********************/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<%@page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page import="com.sitech.boss.pub.util.*" %>
<%
	response.setHeader("Pragma","No-cache");
	response.setHeader("Cache-Control","no-cache");
	response.setDateHeader("Expires", 0);
%>
<HEAD>
<TITLE>
��ѡ�ײ���ϸ
</TITLE>
</HEAD>
<!----------------------------------ҳͷ��ʾ����----------------------------------------->
<body>

<%
//��÷������
String opCode = "1270";
String opName = "��ѡ�ʷ�";
String regionCode = ((String)session.getAttribute("orgCode")).substring(0,2);
/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 begin */
String op_strong_pwd = (String) session.getAttribute("password");
/* liujian ��ȫ�ӹ��޸� 2012-4-6 16:18:13 end */
String op_code = "1270"; 
String cust_id = WtcUtil.repNull(request.getParameter("cust_id"));                        //�ͻ�ID
String maincash_no = WtcUtil.repNull(request.getParameter("maincash_no"));                //���ʷѴ���
String newcash_no = WtcUtil.repNull(request.getParameter("ip"));                          //�����ʷѴ���
if(newcash_no.indexOf(" ")!=-1){
	newcash_no = newcash_no.substring(0,newcash_no.indexOf(" ")); 
}
String belong_code = WtcUtil.repNull(request.getParameter("belong_code"));                //belong_code
String temmode_type = WtcUtil.repNull(request.getParameter("mode_type"));
String mode_type = temmode_type;                                           //mode_type
String sendflag = WtcUtil.repNull(request.getParameter("sendflag"));                      //��Ч��ʽ
String mode_name = WtcUtil.repNull(request.getParameter("mode_name"));                    //�ײ�����
String minopen = WtcUtil.repNull(request.getParameter("minopen"));											  //�õ������С��ͨ��
String maxopen = WtcUtil.repNull(request.getParameter("maxopen"));
String loginNo =(String)session.getAttribute("workNo"); 									//����

//String mode_type = temmode_type.substring(0,1);                       //mode_type
String ret_code="";
String ret_msg="";
System.out.println("op_code1111============"+op_code);
System.out.println("cust_id============"+cust_id);
System.out.println("maincash_no============"+maincash_no);
System.out.println("newcash_no============"+newcash_no);
System.out.println("belong_code============"+belong_code);
System.out.println("mode_type============"+mode_type);
System.out.println("sendflag============"+sendflag);
System.out.println("mode_name============"+mode_name);

	//����s1270Init ������ȡ�����ʷ���Ϣ
  //the1270InitList = callView.s1270InitProcess(op_code, cust_id,maincash_no, newcash_no,belong_code ,mode_type,sendflag,mode_name).getList();
%>
				<wtc:service name="s1270InitNew" routerKey="region" routerValue="<%=regionCode%>" outnum="15" >
					<wtc:param value=""/>
					<wtc:param value="01"/>										
					<wtc:param value="<%=op_code%>"/>
					<wtc:param value="<%=loginNo%>"/>
					<wtc:param value="<%=op_strong_pwd%>"/>	
					<wtc:param value=""/>
					<wtc:param value=""/>
					<wtc:param value="<%=cust_id%>"/>
					<wtc:param value="<%=maincash_no%>"/>
					<wtc:param value="<%=newcash_no%>"/>
					<wtc:param value="<%=belong_code%>"/>
					<wtc:param value="<%=mode_type%>"/>
					<wtc:param value="<%=sendflag%>"/>
					<wtc:param value="<%=mode_name%>"/>
				</wtc:service>
				<wtc:array id="result3" start="0" length="2" scope="end"/>	
				<wtc:array id="result3_2" start="2" length="13" scope="end"/>	
<%

        String test[][] = result3_2;

        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++");
        for(int outer=0 ; test != null && outer< test.length; outer++)
        {
                for(int inner=0 ; test[outer] != null && inner< test[outer].length; inner++)
                {
                        System.out.print(" | "+test[outer][inner]);
                }
                System.out.println(" | ");
        }
        System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++"+ret_code);
		if(result3!=null&&result3.length>0){
			  ret_code = result3[0][0].trim();//�������
			  ret_msg = result3[0][1];//������Ϣ	
		}

   //�Է�����Ϣ�Ŀ���
	  if(ret_msg.equals("")){
				ret_msg = SystemUtils.ISOtoGB(ErrorMsg.getErrorMsg(ret_code));
				if( ret_msg.equals("null")){
					ret_msg ="δ֪������Ϣ";
				}
			}
 /* 
   0 ���ش���            oRetCode           
   1 ������Ϣ            oRetMsg            
   2 ��ѡ�ײʹ���        oModeCode          
   3 ��ѡ�ײ�����        oModeName          
   4 ��ѡ�ײ͵�״̬      oModeStatus        
   5 ��ѡ�ײ͵Ŀ�ʼʱ��  oTmBegin           
   6 ��ѡ�ײ͵Ľ���ʱ��  oTmEnd             
   7 ��ѡ�ײ͵����      oModeType          
   8 ��ѡ�ײ͵���Ч��ʽ  oSendFlagStr       
   9 ��ѡ�ײ͵Ŀ�ͨ��ˮ  oOldAccept         
  10 choiced_flag        oModeChoiced  [0/c]
*/
%>        
 <%
	if(!ret_code.trim().equals("000000")&&!ret_code.equals("17022")){
%>
	  <script language='javascript'>
			  rdShowMessageDialog("��ѯ���󣡴�����룺'<%=ret_code%>'��������Ϣ��'<%=ret_msg%>'��");
			  window.close();
	  </script>
<%
	}
%>
	  
		<%@ include file="/npage/include/header_pop.jsp" %>     	
		<div class="title">
			<div id="title_zi">��ѡ�ʷ���ϸ</div>
		</div>
      
        <TABLE id=thetab cellSpacing="0">
			   <tr align="center">
        		<th>ѡ��</th>            
						<th>��ѡ�ײ�����</th>               
						<th>״̬</th>    
						<th>��ʼʱ��</th> 		   
						<th>����ʱ��</th> 	   
						<th>�ײ����</th> 
            <th>��Ч��ʽ</th>   
            <th>��ѡ��ʽ</th> 
			   </tr>																	   
			   <tr style="display:none">
					   <td><input type="checkbox" name="checkId" id="checkId"></td>
		         <td><div align="center"><input type="text" id="Rinput1" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput2" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput3" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput4" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput5" value=""></div></td>
					   <td><div align="center"><input type="text" id="Rinput6" value=""></div></td>
					   <td><div align="center">
					   		 <input type="text" id="Rinput7" value="">
	               <input type="text" id="Rinput8" value="">
							   <input type="text" id="Rinput9" value="">
							   <input type="text" id="Rinput10" value="">
							   <input type="text" id="Rinput11" value="">
							   <input type="text" id="Rinput12" value="">
							   <input type="text" id="Rinput13" value="">
								 </div>
						  </td>
			   </tr>
			   
<!----------------------------------------------------------------------->

<%
			String[][] data= new String[][]{};
			data = result3_2;
      int kk = 0;
	  if(data.length>0){
	    kk = data[0].length - 2 ;
	  }
	  	String tbclass="";
      for(int y=0;y<data.length;y++){
					if(y%2==0){
	      		tbclass="Grey";
	      	}else{
	      		tbclass="";	
	      	}
	  			String addstr = data[y][0] +"#" +data[y][1]+"#"+y;	  
		  %>
  <tr align="center">
  <%if(data[y][kk].equals("0")){//�ɸĲ�ѡ��%>
  <td class="<%=tbclass%>"><input type="checkbox" name="checkId"  value="<%=addstr%>"></td>

  <%}if(data[y][kk].equals("c")){//���ɸĲ�ѡ��%>
  <td class="<%=tbclass%>"><input type="checkbox" name="checkId"  value="<%=addstr%>" onclick="
	if(document.all.checkId[<%=y%>+1].checked==true){
	document.all.checkId[<%=y%>+1].checked=false;}
	rdShowMessageDialog('����Ч��ʽ�����ʱ���ͻ����������!');
	return false;
	"></td>
  <%     }
		 // System.out.println("data[0].length="+data[0].length);
      for(int j=0;j<data[0].length;j++){
    String tbstr="";
    String temp="";
	//System.out.println("data["+y+"]["+j+"]"+data[y][j].trim());
	if(j==1)
	{
	String habitus ="";
	if(data[y][j].trim().equals("Y"))habitus="�ѿ�ͨ";
	if(data[y][j].trim().equals("N"))habitus="δ��ͨ";
	tbstr = "<td class='"+tbclass+"'>" + habitus + "<input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly></TD>";
	}
	else if(j>6)
	{
	tbstr = " <input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly>";
	}
	else
	{
	tbstr = "<td class='"+tbclass+"'>" + data[y][j].trim() + "<input type='hidden' " +
          		            " id='Rinput" + (j+1) + "' name='Rinput" + (j+1) + "'  value='" + 
          		            (data[y][j]).trim() + "'readonly></TD>";
	}
	out.println(tbstr);
%>

<%
	}
%>
</tr>
<%
    }
%>
<input type="hidden" name="maxopen" value="<%=maxopen%>">
<input type="hidden" name="minopen" value="<%=minopen%>">
          </TABLE>
          
          
		  <TABLE cellSpacing="0">
          <TBODY>
            <TR> 
              <TD id="footer">
						  <!-------------------------------�м�¼ʱ------------------------------------>
						  <input class="b_foot" name=sure  type=button value=ȷ�� onclick="if(maxopen()) returndata();">
              <input class="b_foot" name=close  type=button value=�ر� onclick="window.close()">
					  	<!-------------------------
		              <input name=sure  type=button value=ȷ�� onclick="senddata();">
					 		------�޼�¼ʱ------------------------------------>
              </TD>
            </TR>
          </TBODY>
        </TABLE>
        <%@ include file="/npage/include/footer_simple.jsp" %>
		  <body>
		  </html>
		  
		  
<script language="javascript">
/*----------------------------��ҳ��ѡ�����ݽ��д���--------------------------------*/
function returndata()
{
   
var end = "";
var obj = "";
var thestr = "";
  
for(var i = 1; i<document.all.checkId.length;i++)
	{
		 if(document.all.checkId[i].checked==true)
			{

			 thestr = thestr + document.all.Rinput1[i].value +"|";
			 thestr = thestr + document.all.Rinput2[i].value +"|";
       thestr = thestr + document.all.Rinput3[i].value+"|";
			 thestr = thestr + document.all.Rinput4[i].value+"|";
			 thestr = thestr + document.all.Rinput5[i].value+"|";
			 thestr = thestr + document.all.Rinput6[i].value+"|";
			 thestr = thestr + document.all.Rinput7[i].value+"|";
			 thestr = thestr + document.all.Rinput8[i].value+"|";
			 thestr = thestr + document.all.Rinput9[i].value+"|";
			 thestr = thestr + document.all.Rinput10[i].value+"|";
			 thestr = thestr + document.all.Rinput11[i].value+"|";
			 thestr = thestr + document.all.Rinput12[i].value+"|";
			 if(document.all.Rinput13[i].value==""){
				thestr = thestr +"��������Ϣ"+"|";
			 }else{
				 thestr = thestr + document.all.Rinput13[i].value+"|";
			 }
			 //rdShowMessageDialog("thestr="+thestr);
			/* for(var t=1;t<13;t++)
				 {
				  obj = "Rinput"+ t;
				  thestr = thestr + document.all[i](obj).value +"|";
				 }
			*/
			 }   
    }
          end = thestr;
//rdShowMessageDialog("end="+end);
   window.returnValue=end;
   window.close();
}
function maxopen()
{
	var flag = 0;
	var maxopen1 = '<%=maxopen%>';
	var minopen1 = '<%=minopen%>';
	for(var z = 1;z<document.all.checkId.length;z++)
	{
		if(document.all.checkId[z].checked==true)
		   {flag++;}
	}
	
  var maxopen = parseInt(maxopen1);
	var minopen = parseInt(minopen1);	
	
	if(flag>maxopen||flag<minopen){//���յĿ�ͨ�������ͨ���Ƚ�
		rdShowMessageDialog("���ο�ͨ��Ϊ'"+flag+"'Ӧ��'"+minopen+"'��'"+maxopen+"'֮�䣡");
	  	return false;
	 	} 
	else{return true;}
}
</script>
