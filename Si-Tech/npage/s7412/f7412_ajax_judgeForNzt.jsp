<%
    /*************************************
    * ��  ��: �ж��Ƿ���ũ��ͨҵ�� 7412
    * ��  ��: version v1.0
    * ������: si-tech
    * ������: diling @ 2012-4-10
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  System.out.println("---------ũ��ͨ---begin-----");
  String regionCode   = WtcUtil.repNull((String)session.getAttribute("regCode"));
  String unit_id=(String)request.getParameter("unit_id");
  String vSmCodeList=(String)request.getParameter("vSmCodeList");
  String vProCodeList=(String)request.getParameter("vProCodeList");
  
  String[] vSmCodeArr = vSmCodeList.split("~");
  String[] vProCodeArr = vProCodeList.split("~");
	

  String nztBussFlag ="Y";
	
	String[] sqlNJT1 = new String[2];
	String[] sqlNJT2 = new String[2];
  if(vSmCodeArr !=null) {
    for(int i=0;i<vSmCodeArr.length;i++){
      String productCodeInfo = "";
        productCodeInfo = vProCodeArr[i];
  
      sqlNJT1[0] = "SELECT COUNT(*) FROM SBILLSPCODE WHERE bizcodeadd=:productCodeInfo1 AND srv_code='801'";
      sqlNJT1[1] = "productCodeInfo1="+productCodeInfo;
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode1" retmsg="retMsg1" outnum="1"> 
  <wtc:param value="<%=sqlNJT1[0]%>"/>
  <wtc:param value="<%=sqlNJT1[1]%>"/> 
  </wtc:service>  
<wtc:array id="resultNJT1"  scope="end"/>
<%
    System.out.println("---------ũ��ͨ--------retCode1="+retCode1);
      if(!"000000".equals(retCode1)){
        System.out.println("---------ũ��ͨ-----first--�ж��Ƿ�Ϊũ��ͨ����ʧ�ܣ�");
      }else{
        System.out.println("---------ũ��ͨ-----first---�ɹ���");
        int resultNJT1Int = Integer.parseInt(resultNJT1[0][0]);
        System.out.println("---------ũ��ͨ-----first---resultNJT1Int="+resultNJT1Int);
        if(resultNJT1Int>0){
          sqlNJT2[0] = "SELECT COUNT(*) FROM dgrpusermsgadd a,dgrpusermsg b,dgrpcustmsg c ,dgrpusermsgadd d WHERE a.field_code='1010' AND a.field_value='801' AND a.id_no=b.id_no AND b.cust_id=c.cust_id AND d.id_no=b.id_no AND d.field_code='YWDM0' AND b.run_code='A' AND d.field_value=:productCodeInfo2 AND c.unit_id=:unitId";
          sqlNJT2[1] = "productCodeInfo2="+productCodeInfo+",unitId="+unit_id;
          System.out.println("---------ũ��ͨ-----second---productCodeInfo="+productCodeInfo);  
          System.out.println("---------ũ��ͨ-----second---unit_id="+unit_id);  
%>
          <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1"> 
            <wtc:param value="<%=sqlNJT2[0]%>"/>
            <wtc:param value="<%=sqlNJT2[1]%>"/> 
          </wtc:service>  
          <wtc:array id="resultNJT2"  scope="end"/>
<%
            if(!"000000".equals(retCode2)){
              System.out.println("---------ũ��ͨ-----second---ʧ�ܣ�");    
            }else{
              System.out.println("---------ũ��ͨ-----second---�ɹ���");
               System.out.println("---------ũ��ͨ-----second---resultNJT2[0][0]="+resultNJT2[0][0]);
              int resultNJT2Int = Integer.parseInt(resultNJT2[0][0]);
              if(resultNJT2Int==0){
                System.out.println("---------ũ��ͨ-----second---���û�û�ж���ũ��ͨҵ��");
                nztBussFlag = "N";
                break;
              }
          }
        }
      }
    }
  }
   System.out.println("---------ũ��ͨ-----nztBussFlag="+nztBussFlag);
%>
var response = new AJAXPacket();
response.data.add("nztBussFlag","<%=nztBussFlag%>");
core.ajax.receivePacket(response);
<%
System.out.println("---------ũ��ͨ---end-----");
%>