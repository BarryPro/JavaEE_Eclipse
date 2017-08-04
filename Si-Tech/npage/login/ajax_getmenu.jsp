<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
	String parentNode = request.getParameter("parentNode");
	
		String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
    String workNo = (String)session.getAttribute("workNo");
	String cssPath =(String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
%>
	<wtc:service name="sGetWorkDataNew"  routerKey="region" routerValue="<%=regionCode%>"  outnum="10" >
	<wtc:param value="<%=workNo%>"/>
  	<wtc:param value="1" />
  	<wtc:param value="<%=parentNode%>" />
  	<wtc:param value="999" />
	</wtc:service>
	<wtc:array id="tree" scope="end"/> 
		<%
for(int i = 0;i<tree.length;i++){
	for(int j = 0 ; j <tree[i].length;j++){
		//System.out.println("tree["+i+"]["+j+"]===="+tree[i][j]);
	}
}
if(!retCode.equals("0"))
{
	return;
}
%> 
<%@ include file="dispatch.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/njs/plugins/menubox.js"></script>
<script>

menubox.parentNode='<%=parentNode%>';

with(menubox){
 <%
	//String nodeName="父节点";
	//out.println("N[\"0_"+parentNode+"\"]=\"T:"+nodeName+"\"");
	out.println("N[\"0_"+parentNode+"\"]=\"T:\"");


	//去掉重复的url
	ArrayList treeNew = new ArrayList();
	treeNew.add(tree[0]);

	int treeLen = tree.length;
	for(int i=1;i<treeLen;i++){

			if(!tree[i][3].equals("#"))
			{
				int flag=1;
	      for(int j=0; j<treeNew.size(); j++){
	          String[] leaf = (String[]) treeNew.get(j);
	          if(leaf[3].equals(tree[i][3])){
	            flag = 0;
	          }
	      }
	      if(flag==1){
	    	  treeNew.add(tree[i]);
	      }
			}else
			{
				 treeNew.add(tree[i]);
			}
	}


	//用新的数组生成树
	int treeNewLen = treeNew.size();
	for(int i=0; i<treeNewLen ; i++){
	 String[] leaf = (String[]) treeNew.get(i);
	
		//父id,id,opname,url,验证方式,打开方式
		String tmp = getLink(leaf[7],leaf[3],leaf[1],session,request,leaf[9]);
		if(tmp.equals("#")){
			out.println("N[\""+leaf[0]+"_"+leaf[1]+"\"]=\"T:"+leaf[9]+";C:L('"+leaf[7]+"','"+leaf[1]+"','"+leaf[9]+"','"+tmp+"','"+leaf[5]+"')\";");
		  //System.out.println("N[\""+leaf[0]+"_"+leaf[1]+"\"]=\"T:"+leaf[2]+";C:L('"+leaf[7]+"','"+leaf[1]+"','"+leaf[2]+"','"+tmp+"','"+leaf[5]+"')\";");
		}else{
			out.println("N[\""+leaf[0]+"_"+leaf[1]+"\"]=\"T:["+leaf[1]+"]"+leaf[9]+";C:L('"+leaf[7]+"','"+leaf[1]+"','"+leaf[9]+"','"+tmp+"','"+leaf[5]+"')\";");
		  //System.out.println("N[\""+leaf[0]+"_"+leaf[1]+"\"]=\"T:["+leaf[1]+"]"+leaf[2]+";C:L('"+leaf[7]+"','"+leaf[1]+"','"+leaf[2]+"','"+tmp+"','"+leaf[5]+"')\";");
		}
	}

%> 
	
}
menubox.writeHTML();

</script>

                                                                                                                                                                           