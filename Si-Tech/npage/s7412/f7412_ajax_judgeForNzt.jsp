<%
    /*************************************
    * 功  能: 判断是否有农政通业务 7412
    * 版  本: version v1.0
    * 开发商: si-tech
    * 创建者: diling @ 2012-4-10
    **************************************/
%>
<%@ page contentType="text/html; charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
  System.out.println("---------农政通---begin-----");
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
    System.out.println("---------农政通--------retCode1="+retCode1);
      if(!"000000".equals(retCode1)){
        System.out.println("---------农政通-----first--判断是否为农政通服务失败！");
      }else{
        System.out.println("---------农政通-----first---成功！");
        int resultNJT1Int = Integer.parseInt(resultNJT1[0][0]);
        System.out.println("---------农政通-----first---resultNJT1Int="+resultNJT1Int);
        if(resultNJT1Int>0){
          sqlNJT2[0] = "SELECT COUNT(*) FROM dgrpusermsgadd a,dgrpusermsg b,dgrpcustmsg c ,dgrpusermsgadd d WHERE a.field_code='1010' AND a.field_value='801' AND a.id_no=b.id_no AND b.cust_id=c.cust_id AND d.id_no=b.id_no AND d.field_code='YWDM0' AND b.run_code='A' AND d.field_value=:productCodeInfo2 AND c.unit_id=:unitId";
          sqlNJT2[1] = "productCodeInfo2="+productCodeInfo+",unitId="+unit_id;
          System.out.println("---------农政通-----second---productCodeInfo="+productCodeInfo);  
          System.out.println("---------农政通-----second---unit_id="+unit_id);  
%>
          <wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" retcode="retCode2" retmsg="retMsg2" outnum="1"> 
            <wtc:param value="<%=sqlNJT2[0]%>"/>
            <wtc:param value="<%=sqlNJT2[1]%>"/> 
          </wtc:service>  
          <wtc:array id="resultNJT2"  scope="end"/>
<%
            if(!"000000".equals(retCode2)){
              System.out.println("---------农政通-----second---失败！");    
            }else{
              System.out.println("---------农政通-----second---成功！");
               System.out.println("---------农政通-----second---resultNJT2[0][0]="+resultNJT2[0][0]);
              int resultNJT2Int = Integer.parseInt(resultNJT2[0][0]);
              if(resultNJT2Int==0){
                System.out.println("---------农政通-----second---该用户没有订购农政通业务！");
                nztBussFlag = "N";
                break;
              }
          }
        }
      }
    }
  }
   System.out.println("---------农政通-----nztBussFlag="+nztBussFlag);
%>
var response = new AJAXPacket();
response.data.add("nztBussFlag","<%=nztBussFlag%>");
core.ajax.receivePacket(response);
<%
System.out.println("---------农政通---end-----");
%>