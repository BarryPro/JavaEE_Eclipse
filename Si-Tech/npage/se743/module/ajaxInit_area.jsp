<%
  /*
   * ����: e743 ȫ������ҵ�񶩵�����
   * �汾: 1.0
   * ����: 2012-03-31
   * ����: wanghfa
   * ��Ȩ: si-tech
  */
%>
<%@ page contentType= "text/html;charset=GBK" %>
<%
	String areaId = request.getParameter("areaId");
	String titleName = request.getParameter("titleName");
	String marginTop = request.getParameter("marginTop");
	String marginLeft = request.getParameter("marginLeft"); 
	String showDelBtn = request.getParameter("showDelBtn"); 
	String parentId = request.getParameter("parentId"); 
	System.out.println("-------liujian-------parentId=" + parentId);
%>

<%
//����ɾ��������
if(showDelBtn != null && "true".equals(showDelBtn)) {
%>
<div class="title" id="<%=areaId%>AreaTitle" style="display:none;margin-left:<%=marginLeft%>px;margin-top:<%=marginTop%>px;">
	<div id="title_zi"><%=titleName%><img width="15" height="15" class="closeEl" id="div9_switch" style="cursor: hand;" src="/nresources/default/images/jian.gif" onclick="change(this,'<%=areaId%>')"> <img width="15" height="15" class="closeEl" id="div9_switch" style="cursor: hand;" src="/nresources/default/images/cha.gif" onclick="delArea(this,'<%=areaId%>')"></div>
</div>
<%
}else {
	//����ҳ�������
	if(parentId != null && !"".equals(parentId) && !"null".equals(parentId)) {
		System.out.println("------------liujian------------notNull---parentId=" + parentId );
	%>
	<div class="title" id="<%=areaId%>AreaTitle" style="display:none;margin-left:<%=marginLeft%>px;margin-top:<%=marginTop%>px;">
		<div id="title_zi"><%=titleName%><img width="15" height="15" class="closeEl" id="div9_switch" style="cursor: hand;" src="/nresources/default/images/jian.gif" onclick="change(this,'<%=areaId%>','<%=parentId%>')"></div>
	</div>
	<%
	}else {
		System.out.println("------------liujian------------Null---parentId=" + parentId );
	%>	
	<div class="title" id="<%=areaId%>AreaTitle" style="display:none;margin-left:<%=marginLeft%>px;margin-top:<%=marginTop%>px;">
		<div id="title_zi"><%=titleName%><img width="15" height="15" class="closeEl" id="div9_switch" style="cursor: hand;" src="/nresources/default/images/jian.gif" onclick="change(this,'<%=areaId%>')"></div>
	</div>
	<%
	}
}
%>	

<div class="itemContent" id="<%=areaId%>AreaLoading" style="display:none;margin-left:<%=marginLeft%>px;">
	<img src="/nresources/default/images/protalloading.gif"  width="150" height="30">
</div>
<div id="<%=areaId%>Area" style="display:none;margin-left:<%=marginLeft%>px;">
</div>