<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
/********************
 version v1.0
 ������: si-tech
	at:songjia
 ģ��:1219�ط����
********************/
%>

<%@ include file="/npage/include/public_title_name.jsp" %>
<%@ page contentType="text/html; charset=gbk"%>

<%     
	response.setHeader("Pragma","No-Cache");
  response.setHeader("Cache-Control","No-Cache");
	response.setDateHeader("Expires", 0);
	String opName = "�ط�����";
	String opCode = "1219";
	
	String work_no = (String)session.getAttribute("workNo");
	String workName = (String)session.getAttribute("workName");
	String org_code = (String)session.getAttribute("orgCode");
	String regionCode=org_code.substring(0,2);
	String phone_no =request.getParameter("phone_no");
	String iLoginNo = (String)request.getParameter("iLoginNo");
	String belong_code= (String)request.getParameter("belong_code");
	String region_code =belong_code.substring(0,2);
	String iLoginPwd = (String)request.getParameter("iLoginPwd");
	String iUserPwd = "";
	String iLoginAccept = "0";//��ˮ
	String iChnSource = "06";//������ʶ
	//System.out.println(work_no+"@"+workName+"@"+org_code+"@"+phone_no+"@"+iLoginNo+"@"+iLoginPwd);
	String sm_code=(String)request.getParameter("sm_code"); 
	Map mp = new HashMap();//ID������ӳ��
	String[][] dataRows = new String[][]{};//���ؽ����
	String[][] comeshowRows = new String[][]{};//������ʾ���ؽ����
		try{
%>
<%!
	public String getButtonInfo(String id,String flag,String name){
		if("1".equals(flag)){
		  if("ȫ������".equals(name)||"��������".equals(name)||"������".equals(name)){
			  return "<td><font style='color:red'>�ѿ�ͨ</font></td><td><input type='button' class='b_text' disabled='disabled'  value='ȡ��' onclick=\"goAccept('"+id+"',this.value,'"+name+"')\"/></td>";
		 	}else{
			 	return "<td><font style='color:red'>�ѿ�ͨ</font></td><td><input type='button' class='b_text' value='ȡ��' onclick=\"goAccept('"+id+"',this.value,'"+name+"')\"/></td>";
		 	}
		}else{
			return "<td>δ��ͨ</td><td><input type='button' class='b_text' value='��ͨ' onclick=\"goAccept('"+id+"',this.value,'"+name+"')\"/>";
		}
	}
	
%>
	<wtc:service name="s1219Init" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode" retmsg="retMsg" outnum="37">
		<wtc:param value="<%=iLoginAccept%>"/>
		<wtc:param value="<%=iChnSource%>"/>
		<wtc:param value="<%=opCode%>"/>
		<wtc:param value="<%=iLoginNo%>"/>
		<wtc:param value="<%=iLoginPwd%>"/>
		<wtc:param value="<%=phone_no%>"/>
		<wtc:param value="<%=iUserPwd%>"/>
		</wtc:service>
		<wtc:array id="ms_code_arr" start="1" length="1" scope="end"/>
		<wtc:array id="initStr_1" start="26" length="1" scope="end"/>
		<wtc:array id="initStr_2" start="32" length="1" scope="end"/>
		<wtc:array id="initStr_3" start="28" length="1" scope="end"/>
		<wtc:array id="initStr_4" start="29" length="1" scope="end"/>
			<wtc:array id="initStr_5" start="30" length="1" scope="end"/>
<%
	//System.out.println("=== lipf  === retCode == "+retCode);                 
	if("000000".equals(retCode)){
			sm_code = ms_code_arr[0][0];
			for(int i=0;i<initStr_1.length;i++){
				mp.put(initStr_1[i][0],initStr_2[i][0]);
				//System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				//System.out.println("==lipf=== "+initStr_1[i][0]+"songjia:"+initStr_2[i][0]);
      }
  }
}catch(Exception ex){
%>
	<script type="text/javascript">
		rdShowMessageDialog("���÷���s1219Init����",0);
		return;
	</script>
<%}%>
<%
	//System.out.println("=== lipf  = === speinfo.jsp == == sm_code == "+sm_code);
	String sql = "select product_id,function_name from sfunclist where show_flag='Y' and region_code=:region_code and sm_code=:sm_code and function_name in('��������','������ʾ','����ͨ��','���еȴ�','���ʳ�;','��������','��������','����ͨѶ','���ӵ绰','GPRS','ȫ������','GPRSҵ��','������','WLAN�Զ���֤')";
	String myParams="region_code="+region_code+",sm_code="+sm_code;
	//add by lipf 20120629 ��������ʾ������������5Ԫ��ʮԪ�ȵȰ����������ʾ������ʾ��ͨ
	String comeshowSql="SELECT A.PRODUCT_ID, '������ʾ' FROM SFUNCLIST A  WHERE A.REGION_CODE =:region_code  AND A.SM_CODE =:sm_code AND A.COMMAND_CODE ='19'";
	String comeshowParams="region_code="+region_code+",sm_code="+sm_code;
	//System.out.println("=== lipf  === sql == "+sql+"  ==comeshowSql== "+comeshowSql);
	
%>
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=sql%>"/>
		<wtc:param value="<%=myParams%>"/>	
	</wtc:service>
	<wtc:array id="queryList"  scope="end"/>	
	<!--add by lipf 20120629������ʾ����-->
	<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="2">
		<wtc:param value="<%=comeshowSql%>"/>
		<wtc:param value="<%=comeshowParams%>"/>	
	</wtc:service>
	<wtc:array id="comeshowList"  scope="end"/>
	<%
	dataRows = queryList;
	comeshowRows=comeshowList;
	//System.out.println("=== lipf  === dataRows.length == "+dataRows.length);
%>

<html  xmlns="http://www.w3.org/1999/xhtml">
<HEAD><TITLE>�ط�����</TITLE>
</HEAD>

<script language="JavaScript">
<!--
window.onload=function() {
	window.top.openTFFlag = 0; //������֤���Ƿ���ط�ҳ���ʶ��ԭ
	var newHeight = document.body.scrollHeight + 20 + "px";
	var newWidth = document.body.scrollWidth + 20 + "px";
	window.parent.document.getElementById("showCustWTab").style.height = newHeight;
	window.parent.document.getElementById("showCustWTab").style.width = newWidth;
	window.parent.document.getElementById("iFrame1").style.height = newHeight;
	window.parent.document.getElementById("iFrame1").style.width = newWidth;
}
function goAccept(id,status_text,name)
{
		var open_flag="";
		if(status_text == "��ͨ"){
			open_flag="1";
		}else if(status_text == "ȡ��"){
			open_flag="0";
		}else return;
		if(rdShowConfirmDialog("ȷ��Ҫ�ύô?")==1)
		{
					var packet = new AJAXPacket("speinfo_do.jsp","���Ժ�...");//��ϲ�Ʒ�Ӳ�Ʒչʾ
					packet.data.add("open_flag" ,open_flag);
					packet.data.add("id" ,id);
					packet.data.add("phone_no","<%=phone_no%>");//�ֻ�����
					packet.data.add("iLoginNo","<%=iLoginNo%>");//����
					packet.data.add("iLoginPwd","<%=iLoginPwd%>");//��
					packet.data.add("sm_code","<%=sm_code%>");//��
					packet.data.add("name",name);//��
					packet.data.add("belong_code","<%=belong_code%>");//����
					
					core.ajax.sendPacket(packet,doback);
					packet =null;
		}
	
}
function doback(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
		rdShowMessageDialog("���������"+retMsg,2);
		parent.toTF();
		
}
function doStart(flag){
	if(rdShowConfirmDialog("ȷ��Ҫ�ύô?")==1)
		{
					var packet = new AJAXPacket("speshormsg.jsp","���Ժ�...");//��ϲ�Ʒ�Ӳ�Ʒչʾ
					packet.data.add("flag" ,flag);
					packet.data.add("phone_no","<%=phone_no%>");//�ֻ�����
					packet.data.add("iLoginNo","<%=iLoginNo%>");//����
					core.ajax.sendPacket(packet,dobackmsg);
					packet =null;
		}
}
function dobackmsg(packet){
		var retCode = packet.data.findValueByName("retCode");
		var retMsg = packet.data.findValueByName("retMsg");
                if( retCode == "000000" )
		{
	   	        rdShowMessageDialog("���������"+retMsg,2);
		}
                else
		{
			rdShowMessageDialog("���������"+retMsg,0);
		}
}
</script>
<body>

<FORM method=post name="form1" onKeyUp="chgFocus(form1)">
	<DIV id="Operation_Table" style="width:765px">  
  	
		<div class="title">
			<div id="title_zi"><%=opName%></div>
		</div>

			 <table cellspacing="0">		  
        	<TBODY id="speData"> 
							<%
							for(int i=0;i<dataRows.length;i++){
								//System.out.println("== lipf=  sm_code  == "+sm_code+" ==region_code=="+region_code+" ====dataRows[i][0]  ==== "+dataRows[i][0]+"  === dataRows[i][1] ==== "+dataRows[i][1]);
									
									 
									//add by lipf 20120629 �����������ʾ��Ԫ��ʮԪ�ȣ�����ʾΪ������ʾ
									if("������ʾ".equals(dataRows[i][1])){
										if(comeshowRows!=null){
											for(int j=0;j<comeshowRows.length;j++){
												if(mp.containsKey(comeshowRows[j][0])){
													dataRows[i][0]=comeshowRows[j][0];
													break;
												}
											}
										}
									}
								 	if(!mp.containsKey(dataRows[i][0])){ 
								 	  out.print("<tr>");
								 	  out.print("<th>"+dataRows[i][1]+"</th>");
										out.print(getButtonInfo(dataRows[i][0],"0",dataRows[i][1]));
									}
								    out.print("</tr>");
							}
								for(int i=0;i<dataRows.length;i++){
								//System.out.println("== lipf=  sm_code  == "+sm_code+" ==region_code=="+region_code+" ====dataRows[i][0]  ==== "+dataRows[i][0]+"  === dataRows[i][1] ==== "+dataRows[i][1]);
									
									
									
									//add by lipf 20120629 �����������ʾ��Ԫ��ʮԪ�ȣ�����ʾΪ������ʾ
									if("������ʾ".equals(dataRows[i][1])){
										if(comeshowRows!=null){
											for(int j=0;j<comeshowRows.length;j++){
												if(mp.containsKey(comeshowRows[j][0])){
													dataRows[i][0]=comeshowRows[j][0];
													break;
												}
											}
										}
									}
								 	if(mp.containsKey(dataRows[i][0])){ 
								 	  out.print("<tr>");
								 	  out.print("<th>"+dataRows[i][1]+"</th>");
										out.print(getButtonInfo(dataRows[i][0],"1",dataRows[i][1]));
									}
								    out.print("</tr>");
							}
								
								
								
								%>
					
          </TBODY>
        </table>
    <div class="title">
			<div id="title_zi">�շѶ�������</div>
		</div> 
		 <table cellspacing="0">		  
        	<TBODY> 
					<tr>
						<th>�շѶ�������</th>
						<td>
							<input type="button" class="b_text" value="��ͨ" onclick="doStart('01')"/>
							<input type="button" class="b_text" value="�ر�" onclick="doStart('02')"/>
							</td>
					</tr>
				</TBODY>
			</table>
 </div>
</form>
</body>
</html>
