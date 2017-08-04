<%
    /*************************************
    * ��  ��: �������ܿز�ѯ e874
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-6-7
    **************************************/
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page contentType="text/html;charset=GBK"%>
<%@ include file="/npage/include/public_title_name.jsp" %>

<%
    String opCode=request.getParameter("opCode");
    String opName=request.getParameter("opName");
    String workNo=WtcUtil.repNull((String)session.getAttribute("workNo"));
    String regionCode=WtcUtil.repNull((String)session.getAttribute("regCode"));
    String loginNoCount = "";
    String regionName="";

    //��ȡ���ݿ�ʱ��sql��
    String Strsql = "select to_char(sysdate-1,'yyyy-mm-dd hh24:mi:ss'),to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual";
%>
    <wtc:pubselect name="sPubSelect" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="2">
        <wtc:sql><%=Strsql%></wtc:sql> 	
    </wtc:pubselect>
    <wtc:array id="result" scope="end"/> 
<%
    //��ȡ��ǰ���ݿ�ʱ��-24Сʱ��
    String befor24Time = result[0][0];
    //���ݿ�ʱ�䣺
    String currentTimeString = result[0][1];
    
    String  inParams [] = new String[2];
    inParams[0] = "select count(*) from shighlogin where op_code=:opcode and login_no=:loginno";
    inParams[1] = "opcode="+opCode+",loginno="+workNo;
%>
    <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="2"> 
      <wtc:param value="<%=inParams[0]%>"/>
      <wtc:param value="<%=inParams[1]%>"/> 	
    </wtc:service> 
    <wtc:array id="countResult" scope="end"/> 
<%
  if("000000".equals(retCode2)){
    loginNoCount = countResult[0][0];
    System.out.println("---e874-----countResult[0][0]="+countResult[0][0]);
    System.out.println("---e874-----loginNoCount="+loginNoCount);
    if("1".equals(countResult[0][0])){ //��¼����Ϊaavg21���ţ��ɲ�����л�ȫʡ
  		regionName="select region_code,region_name from sregioncode where region_code in('01','02','03','04','05','06','07','08','09','10','11','12','13') order by to_number(region_code)";
  	}else{
  		regionName="select region_code,region_name from sregioncode where region_code='"+regionCode+"'";
  	}
  }
  
%>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>�������ܿز�ѯ</title>
    <META content="MSHTML 5.00.3315.2870" name=GENERATOR>
    <script language="javascript">
      window.onload=function()
      {
          //ʱ��Ĭ����ʾ
          $("#startTime").val("<%=befor24Time%>");
          //$("#startTime").val("2012-06-26 13:25:11")
          
          $("#endTime").val("<%=currentTimeString%>");
          /*begin diling add for ����ѡ��仯��ʱ�䶼�ɱ�*/
          $("#region_code").change(function(){
            //alert($(this).children('option:selected').val());
            $("#startTime").removeAttr("disabled");
            $("#endTime").removeAttr("disabled");
          });
          /*end diling add for ����ѡ��仯��ʱ�䶼�ɱ�*/
      }
    
      //У��ʱ���ʽ
      function checkTimeFormat(){
        if(!forDate(document.frme874.startTime)){
          return false;
        }
        if(!forDate(document.frme874.endTime)){
          return false;
        }
      }
      
      function query(submitBtn2)
      {
        /* ��ť�ӳ� */
        controlButt(submitBtn2);
        /* �º����� */
        getAfterPrompt();
        
        var markDiv=$("#intablediv"); 
        markDiv.empty();
        
        if(!forDate(document.frme874.startTime)){
          return false;
        }
        
        if(!forDate(document.frme874.endTime)){
          return false;
        }
        if(!check(frme874)) return false;
        
        var startTime=$.trim($("#startTime").val());
        var endTime=$.trim($("#endTime").val());
        var befor24TimeVar = "<%=befor24Time%>";
        var currentTimeVar = "<%=currentTimeString%>";
        if(Date.parse(startTime.replace("-","/"))>Date.parse(endTime.replace("-","/")))
        {
        rdShowMessageDialog("��ʼʱ��ӦС�ڽ���ʱ�䣬���������룡");
          return false;	
        }
        
        if(Date.parse(endTime.replace("-","/"))>Date.parse(currentTimeVar.replace("-","/")))
        {
          rdShowMessageDialog("����ʱ����ڵ�ǰϵͳʱ�䣬���������룡");
          return false;	
        }
        var regionCodes = document.getElementById("region_code");
        var regionCodeValue = "";
        for(var i = 0;i<regionCodes.length;i++){
          if(regionCodes[i].selected==true){
            regionCodeValue = regionCodes[i].value;
            //alert(regionCodeValue);
            if(regionCodeValue=="$$$$$$"){
              rdShowMessageDialog("��ѡ����У�");
              return false;
            }
           }
        }
        /*** begin diling update for ���ѯ����������ʱ���û�@2012/8/23 ***/
        if(regionCodeValue=="00"){
          $("#startTime").attr("disabled","true");
          $("#endTime").attr("disabled","true");
        }else{
          $("#startTime").removeAttr("disabled");
          $("#endTime").removeAttr("disabled");
        }
        /*** end diling update @2012/8/23 ***/
        var packet = new AJAXPacket("fe874_ajax_query.jsp","���ڻ�����ݣ����Ժ�......");
        packet.data.add("startTime",startTime);
        packet.data.add("endTime",endTime);
        packet.data.add("opCode","<%=opCode%>");
        packet.data.add("region_code",regionCodeValue);
        core.ajax.sendPacketHtml(packet,doQuery);
        packet = null;
       }
  	
      function doQuery(data)
      {
        //�ҵ���ӱ���div
				var markDiv=$("#intablediv"); 
				markDiv.empty();
    		markDiv.append(data);
        var retCode = $("#retCode").val();
        var retMsg = $("#retMsg").val();
        if(retCode!="000000"){
          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
          return false;
        }
      }
      
      function goBack(){
        window.location.href="fe874_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
      }
      
      function chgMsg(obj,groupId){
         var _thisTd = obj.parentNode.parentNode.childNodes;
         var _limitRatio = _thisTd[5].children[0].id;
         //jquery��ȡҳ���ȫ����input Ȼ��ѭ�����е�input
         var inputArray=$('input[value=�޸�]');//ȡ�����е�input ���ҷŵ�һ��������
         //Ҳ����ʹ�������forѭ����ѭ��input����
         //alert(inputArray.length);
        for(var i=0;i<inputArray.length;i++){//ѭ������input����
            var input =inputArray[i];//ȡ��ÿһ��input
            var inputId = input.id;
            $("#"+inputId).attr("disabled","true");
        }
        if(obj.value=="�޸�"){
          var objId = obj.id;
          $("#"+objId).attr("disabled","");
          //obj.className = "InputGrey";
          obj.value="ȷ��";
          $("#"+_limitRatio).removeClass("InputGrey");
          $("#"+_limitRatio).removeAttr("readonly");
        }else{
          obj.onClick=saveMsg(obj,groupId);
        }
      }
      
      function saveMsg(obj,groupId){
        var _thisTd = obj.parentNode.parentNode.childNodes;
        var _limitRatio = _thisTd[5].children[0].id;
        var v_limitRatioVal = $("#"+_limitRatio).val();
        var limitRatioVal = v_limitRatioVal.substring(0,v_limitRatioVal.length-1);/*ȥ���ٷֺŵ�����ռ��*/
        //alert(limitRatioVal);
        //alert(limitRatioVal.length);
        
        //var reg =/^[[0-9]+\%[0-9]*|[0-9]*\%[0-9]+]*$/;
        var reg =/^[[0-9]+\.{0,1}[0-9]*\%]*$/;
        if(v_limitRatioVal==""){
          rdShowMessageDialog("����ռ�Ȳ���Ϊ�գ�");
          return false;
        }else{
          if(reg.test(v_limitRatioVal) == false){
            rdShowMessageDialog("����ռ�ȱ���Ϊ����+%��ɣ�");
            return false;
          }
        }
        /*
        if(limitRatioVal.length>=6){
          rdShowMessageDialog("����ռ��λ�����ܳ���5λ��");
          return false;
        }*/
        
        if(limitRatioVal>100){
          rdShowMessageDialog("����ռ�Ȱٷ������ܴ���100��");
          return false;
        }
        
        var packet = new AJAXPacket("fe874_ajax_saveMsg.jsp","���ڻ�����ݣ����Ժ�......");
        packet.data.add("limitRatioVal",limitRatioVal);
        packet.data.add("groupIdVal",groupId);
        packet.data.add("opCode","<%=opCode%>");
        core.ajax.sendPacket(packet,doSaveMsg);
        packet = null;
      }
      
      function doSaveMsg(packet){
        var retCode = packet.data.findValueByName("retcode");
        var retMsg = packet.data.findValueByName("retmsg");
        if(retCode!="000000"){
          rdShowMessageDialog("������룺"+retCode+"<br>������Ϣ��"+retMsg,0);
          window.location.href="fe874_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        }else{
          rdShowMessageDialog("�ύ�ɹ���",2);
          window.location.href="fe874_main.jsp?opCode=<%=opCode%>&opName=<%=opName%>";
        }
      }
    </script>
  </head>
<body>
  <form name="frme874" method="post" >
   	<input type="hidden" id="opCode" name="opCode"  value="" />
   	<input type="hidden" id="opName" name="opName"  value="" />
  	<%@ include file="/npage/include/header.jsp" %>
  	<div class="title">
  		<div id="title_zi">�����ѯ����</div>
  	</div>
      <table cellspacing="0">
          <tr>
              <td class="blue">��ʼʱ��</td>
              <td>
                  <input type="text" id="startTime" name="startTime" v_format="yyyy-MM-dd HH:mm:ss"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
                  <font color="orange">* ( �����ʽ��yyyy-MM-dd HH:mm:ss )</font>
              </td>
              <td class="blue">����ʱ��</td>
              <td>
                  <input type="text" id="endTime" name="endTime" v_format="yyyy-MM-dd HH:mm:ss"  v_must="1"  class="button" maxlength="19" onblur="checkTimeFormat()" />&nbsp;
                  <font color="orange">* ( �����ʽ��yyyy-MM-dd HH:mm:ss )</font>
              </td>
          </tr>
          <tr>
              <td class="blue">����</td>
              <td colspan="3">
                 <select id="region_code"  v_name="����">
						<option value="$$$$$$">��ѡ��</option>
						<%
						  if("1".equals(loginNoCount)){
						%>
						    <option value="00">������</option>
						<%
						}
						%>
              <wtc:pubselect name="sPubSelect" outnum="2"  retcode="retCode3" retmsg="retMsg3" routerKey="region" routerValue="<%=regionCode%>">
                <wtc:sql><%=regionName%></wtc:sql>
              </wtc:pubselect>
              <wtc:array id="result_t" scope="end"/>
            <%
							String[][] retListString = new String[][]{};
							if(("000000").equals(retCode3)&&result_t.length>0)
							  retListString = result_t;
								for(int i=0;i < retListString.length;i ++)
								{
							%>
    		          <option value='<%=retListString[i][0]%>'><%=retListString[i][1]%></option>
							<%		
								}
							%>
				      </select>&nbsp;<font class="orange">*<font>
              </td>
          </tr>			
          <tr>
              <td colspan="4" align="center" id="footer">
                  <input type="button" id="submitBtn" name="submitBtn" class="b_foot" value="��ѯ" onClick="query(this)" />   
                  <input type="button" id="reSetBtn"  name="reSetBtn"  class="b_foot" value="����" onClick="goBack();" /> 
                  <input type="button" id="closeBtn"  name="closeBtn"  class="b_foot" value="�ر�" onClick="removeCurrentTab();" />
              </td>
          </tr>
      </table>
    <div id="intablediv"></div>
    <%@ include file="/npage/include/footer.jsp" %>
  </form>
</body>
</html>