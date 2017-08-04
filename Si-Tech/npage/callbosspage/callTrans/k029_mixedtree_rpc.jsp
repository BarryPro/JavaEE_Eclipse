<%
  /*
   * 功能: 来电原因填写->原因树的数据提取
　 * 版本: 1.0.0
　 * 日期: 2009/4/7
　 * 作者: jiangbing
　 * 功能说明: 分为四种情况的html生成：
　 * 1、正常的父节点点击，生成html，这种情况需要输入参数nodeId，此方法查询数据库，返回父节点为nodeId的子节点
　 * 2、初始化虚拟父节点，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=1，此方法不查询数据库，返回虚拟父节点，虚拟节点的id=nodeId
　 * 3、初始化实体父节点，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=0，此方法查询数据库，返回nodeId的节点
　 * 4、根据查询caption相似，来初始化列表，生成html，这种情况需要输入参数nodeId、isRoot=1、isVisual=0、caption，此方法查询数据库，返回符合条件的叶子节点html
　 * 版权: sitech
   * update:
　 */
%>
<%@ page contentType="text/html;charset=gbk"%>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%@ include file="/npage/callbosspage/callTrans/k029_mixedtree_rpc_method.jsp" %>
<%@ page import="com.sitech.crmpd.core.wtc.util.*,java.util.*"%>

<%
 response.setHeader("Pragma", "No-cache");   
 response.setHeader("Cache-Control", "no-cache");
 response.setHeader("Expires", "0"); 
 System.out.println("");
 String orgCode = (String)session.getAttribute("orgCode");
 String regionCode = orgCode.substring(0,2);
 String myParams="";
 String myParams1="";
 String CityCode="";
 String CalledNo=request.getParameter("CalledNo");
 if(CalledNo!=null){
 		CalledNo = CalledNo.trim();
 }
 
 String UserClass=request.getParameter("UserClass");
 if(UserClass!=null){
 		UserClass = UserClass.trim();
 }
 CityCode=request.getParameter("CityCode");
System.out.println("CityCode from getParameter:"+CityCode);
 if(CityCode!=null){
 		CityCode = CityCode.trim();
 }
 String ServiceNo=request.getParameter("ServiceNo");
 if(ServiceNo!=null){
 		ServiceNo = ServiceNo.trim();
 }
 String inFlag=request.getParameter("inFlag");
 
 String hasSelectNodes = request.getParameter("hasSelectNodes");
 if(hasSelectNodes!=null){
 		hasSelectNodes = hasSelectNodes.trim();
 }else{
 		hasSelectNodes = "";
 	}
 	

 String nodeId = request.getParameter("nodeId");
 String isRoot = request.getParameter("isRoot");
 if(isRoot==null){
 	isRoot = "";
 }
 String nodeLevel = request.getParameter("nodeLevel");
 nodeLevel = new Integer(Integer.parseInt(nodeLevel)+1).toString();
 String lastChildRoute = request.getParameter("lastChildRoute");

 String hasSelectOption = request.getParameter("hasSelectOption");
 String sqlStr="";
 StringBuffer res = new StringBuffer();

//System.out.println("isRoot?:"+isRoot);
 //正常的父节点点击
 if(isRoot.equals("")||isRoot.equals("0")){
 		if(nodeId!=null&&!nodeId.equals("")){
       if(inFlag.equals("0")){
        	sqlStr="select a.id,a.superid ,a.servicename,DECODE(decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),'2001','0','1'),";
        	sqlStr=sqlStr+"decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
        	sqlStr=sqlStr+"and a.typeid<>0 and a.superid=:nodeId  order by a.id " ;
        	myParams ="nodeId="+nodeId;
       }
       else{
         	sqlStr="select a.id,a.superid ,a.servicename,DECODE( decode((select count(*) from DZXSCETRANSFERTAB c where c.superid=a.id AND c.visiable = '1') ,'0','2004','2003'),'2003','0','1'),"
         	+"decode((select count(*) from DZXSCETRANSFERTAB c where c.superid=a.id AND c.visiable = '1') ,'0','2004','2003'),a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
         	if(nodeId.indexOf("*")!=nodeId.length()-1){
         		sqlStr=sqlStr+"and a.superid=:nodeId  " ;
         		myParams ="nodeId="+nodeId;
         	}else{
         		String nodeLike = nodeId.substring(0,nodeId.length()-1);
         		sqlStr=sqlStr+"and ( a.id!=:nodeId  and  (a.superid='"+nodeLike+"' or substr(a.superid,0,length(a.superid)-1)=:vnodeLike)) " ;
         		myParams ="nodeId="+nodeId+",nodeLike="+nodeLike+",vnodeLike="+nodeLike;
         	}
         	sqlStr=sqlStr+" and a.visiable = '1' " ;
         	//yanghy 华为添加是否可见的字段. 1 是可见.20090910
         	sqlStr=sqlStr+"order by a.id " ;

       }
    }
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="9" >

<% 
	for(int i = 0; i < resultList.length; i++){
    String isLast = "0";
	  if(i==resultList.length-1){
	  	 isLast="1";	  	
	   }  
	  String lastChildRoute_ = (lastChildRoute.equals("")?lastChildRoute:(lastChildRoute+","))+isLast;
	  
    getNodeHtml(res,resultList[i],nodeLevel,isLast,lastChildRoute_,hasSelectOption,"0",hasSelectNodes);
	}
%>
</wtc:array>
<% 
}else{
      
      String isVisual = request.getParameter("isVisual");
  
      if(isVisual==null){
           isVisual = "";
      }
 			
      //初始化实体父节点
      if(isVisual.equals("")||isVisual.equals("0")){
           //added liujied
           System.out.println("in 初始化实体副节点");
           //取不到CityCode和CallNo
           System.out.println("CityCode:"+CityCode);
           System.out.println("CalledNo:"+CalledNo);
           System.out.println("UserClass:"+UserClass);
           
           if(!CityCode.equals("")&&!CalledNo.equals("")&&!UserClass.equals("")){
                System.out.println("in Citycode");
                if(inFlag.equals("0")){
                     System.out.println("in k029_2rpc_sql_1");
                     //sqlStr="select a.id,a.superid ,a.servicename,DECODE(a.typeid,'2001','0','1'),a.typeid,a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
                     sqlStr="select a.id,a.superid ,a.servicename,DECODE(decode(a.typeid,'2002', decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.typeid),'2001','0','1'), ";
                     sqlStr=sqlStr+"decode(a.typeid,'2002', decode((select count(*) from DSCETRANSFERTAB c where c.superid=a.id) ,'0','2002','2001'),a.typeid),a.ttansfercode,a.digitcode,a.userclass,a.usertype from DSCETRANSFERTAB a where 1=1 ";
                     sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
                     sqlStr=sqlStr+"and userclass=:UserClass ";
                     sqlStr=sqlStr+"and citycode=:CityCode ";
                     //sqlStr=sqlStr+"and a.typeid in('2001','2002','2003','2004') and not exists( select 1 from DSCETRANSFERTAB b where b.id=a.superid ) order by a.id " ;
                     sqlStr=sqlStr+"and a.typeid in('2001','2002','2003','2004') and not exists( select 1 from DSCETRANSFERTAB b where b.id=a.superid and b.typeid in ('2001','2002','2003','2004')) order by a.id " ;
                     myParams1 = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
                     System.out.println(sqlStr);
                }
                else{
                     System.out.println("in k029_2rpc_sql_2");
                     sqlStr="select a.id,a.superid ,a.servicename,DECODE(a.typeid,'2003','0','1'),a.typeid,a.transfercode,a.digitcode,a.userclass,a.usertype from DZXSCETRANSFERTAB a where 1=1 ";
                     sqlStr=sqlStr+"and a.accesscode=:CalledNo ";
                     sqlStr=sqlStr+"and userclass=:UserClass ";
                     sqlStr=sqlStr+"and citycode=:CityCode ";
                     sqlStr=sqlStr+" and a.visiable = '1' " ;
                     sqlStr=sqlStr+"and not exists( select 1 from DZXSCETRANSFERTAB b where b.id=a.superid) " ;
                     sqlStr=sqlStr+"and (a.id=a.superid||'*' or ";
                     sqlStr=sqlStr+"(not exists( select 1 from DZXSCETRANSFERTAB b where b.id=a.superid||'*') and ";
                     sqlStr=sqlStr+"not exists( select 1 from DZXSCETRANSFERTAB b where b.id=substr(a.superid,0,length(a.superid)-1)||'*')) ";
                     sqlStr=sqlStr+") order by a.id " ;
                     myParams1 = "CalledNo="+CalledNo+",UserClass="+UserClass+",CityCode="+CityCode;
                }
           }
           
%>
<wtc:service name="TlsPubSelCrm" routerKey="region" routerValue="<%=regionCode%>" outnum="9">
	<wtc:param value="<%=sqlStr%>"/>
	<wtc:param value="<%=myParams1%>"/>
</wtc:service>
<wtc:array id="resultList" start="0" length="9" >
<%
      for(int i = 0; i < resultList.length; i++)
      {
           String isLast = "0";
           if(i==resultList.length-1)
           {
                isLast="1";	  	
           }  
           getNodeHtml(res,resultList[i],"1",isLast,isLast,hasSelectOption,"0",hasSelectNodes);
      }
%>
</wtc:array>
<% 
       }			
      else
      {
           String[] param = {"0","-1","IVR","0","IVR"};
           getNodeHtml(res,param,"1","1","1",hasSelectOption,isRoot,hasSelectNodes);
      }
 }
%>
var response = new AJAXPacket();
response.data.add("worknos","<%=res.toString()%>");
response.data.add("nodeId","<%=nodeId%>");
core.ajax.receivePacket(response);


