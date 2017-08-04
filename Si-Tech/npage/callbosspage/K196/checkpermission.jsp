<%
String sysRoles=(String)session.getAttribute("powerCodekf");
%>
<script type="text/javascript" src="/njs/csp/funcRoleRel.js"></script>
<script>
function checkRole(pArr){
	var temp='<%=sysRoles%>';
	lArr=temp.split(',');
	var flag=false;
	if(pArr.length>0){
		for(var i=0;i<pArr.length;i++){
			for(var j=0;j<lArr.length;j++){
				if(lArr[j]==pArr[i]){
					flag=true;
					break;
				}
			}
		}
}
	return flag;
}	

	
</script>	
