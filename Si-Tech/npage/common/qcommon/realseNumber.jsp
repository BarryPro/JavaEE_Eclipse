
<%  
		String gs_PSite_Cur=(String)session.getAttribute("objectId")==null?"":((String)session.getAttribute("objectId")).trim();
		String workNo0022=(String)session.getAttribute("workNo")==null?"":((String)session.getAttribute("workNo")).trim();	
%>
<script type="text/javascript">
function releaseGUNum(NUM){

	var selType=1;//�������ͣ���ҳ��Ҫ���壬��ʱɾ��
//NUMΪ��Ҫ�ͷŵĺ������봮��
  var myPacket = new AJAXPacket("/npage/common/qcommon/middle_1.jsp","�����ͷź�����Ϣ�����Ժ�......");       
  myPacket.data.add("retType","releaseGUNum");
  myPacket.data.add("NUM",NUM); 
  myPacket.data.add("BRANCH_ID",branchNo);
  myPacket.data.add("STAFF_ID",'<%=session.getAttribute("workNo")%>');
  myPacket.data.add("SITE_ID",objectId);
  myPacket.data.add("NUM_TYPE","06");
  myPacket.data.add("OBJECT_TYPE","1");
  myPacket.data.add("CITY_ID",'<%=session.getAttribute("cityId")%>'); 
  core.ajax.sendPacket(myPacket,doProcess);
	chkPacket =null;
}
function releaseADSLNum(NUM)
{  
//NUMΪ��Ҫ�ͷŵĺ������봮��
	NUM=NUM.replace('~','|'); 	   
	var myPacket = new AJAXPacket("/npage/common/qcommon/okFreeNum.jsp","�����ύ�����Ժ�......");
	myPacket.data.add("retType","releaseADSLNum");
	myPacket.data.add("account",NUM);
	myPacket.data.add("city_id",'<%=session.getAttribute("cityId")%>');
	myPacket.data.add("work_form_id","<%=workFormId%>");
	myPacket.data.add("conn_flag",selType);
	myPacket.data.add("staff_id","<%=workNo0022%>");
	myPacket.data.add("lastaccount","");
	myPacket.data.add("branch_no",branchNo);
	myPacket.data.add("prod_id",prodId.trim());
	myPacket.data.add("svc_inst_id","<%=svcInstId%>");
	core.ajax.sendPacket(myPacket);
	myPacket=null;
	}
function	release3GNum(NUM)
{
//NUMΪ��Ҫ�ͷŵĺ������봮��
	var myPacket = new AJAXPacket("/npage/common/qcommon/3GmiddleCancel.jsp","�����ͷź�����Ϣ�����Ժ�......");	
	myPacket.data.add("retType","release3GNum");
	myPacket.data.add("cancelStr",NUM);
	core.ajax.sendPacket(myPacket);
	myPacket=null;
}
/*
var preCancelState=1;
function cancelFun(packet){
		var errCode_1 = packet.data.findValueByName("errCode_1");
		if(jtrim(errCode_1)!="000000")
		{
			rdShowMessageDialog("�����ͷ�ʧ��,�������Ա��ϵ��");
			preCancelState=0;
			return false;
		}
		else
		{
			document.all.selNum.value="";
			preCancelState=1;		
		}
}
*/
</script>