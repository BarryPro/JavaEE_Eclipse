<%@ page contentType= "text/html;charset=GBK" %>
<%@ include file="/npage/include/public_title_ajax.jsp" %>
<%
    String workNo = (String)session.getAttribute("workNo");
    String orgCode = (String)session.getAttribute("orgCode");
	String regionCode = orgCode.substring(0,2);
	String cssPath = (String)session.getAttribute("themePath")==null?"default":(String)session.getAttribute("themePath");
		/** modified by hejwa in 20110719 多OP改造--收藏夹功能 begin**/
%>

<script type="text/javascript">
var mh   = 30; //最小高度
var step = 10; //每次变化的px量
var ms   = 1; //每隔多久循环一次
//折叠速度的设置方法
function toggle(o,bt){
var imgPath  = "<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/";

var cuImgSrc = $(bt).parent().find("img").attr("src");
cuImgSrc = cuImgSrc.substring(cuImgSrc.lastIndexOf("/")+1,cuImgSrc.length);
if(cuImgSrc!="arrow_dleft.gif"){
	cuImgSrc = "arrow_dleft.gif";
}else if(cuImgSrc!="arrow_ddown.gif"){
	cuImgSrc = "arrow_ddown.gif";
}
cuImgSrc = imgPath+cuImgSrc;
$(bt).parent().find("img").attr("src",cuImgSrc)
if (!o.tid)o.tid = "_" + Math.random() * 100;
if (!window.toggler)window.toggler = {};
if (!window.toggler[o.tid]){
    window.toggler[o.tid]={
      obj:o,
      maxHeight:o.offsetHeight,
      minHeight:mh,
      timer:null,
      action:1
    }; }
o.style.height = o.offsetHeight + "px";
if (window.toggler[o.tid].timer)clearTimeout(window.toggler[o.tid].timer);
window.toggler[o.tid].action *= -1;
window.toggler[o.tid].timer = setTimeout("anim('"+o.tid+"')",ms );//注意计时器的用法
}
//通过对象的最小高度和最大高度，判断折叠是否停止
function anim(id){
var t = window.toggler[id];
var o = window.toggler[id].obj;
if (t.action < 0){
    if (o.offsetHeight <= t.minHeight){
      clearTimeout(t.timer);
      return;
    }
}
else{
    if (o.offsetHeight >= t.maxHeight){
      clearTimeout(t.timer);
      return;
    }
}
o.style.height = (parseInt(o.style.height, 10) + t.action * step) + "px";
window.toggler[id].timer = setTimeout("anim('"+id+"')",ms );
}
</script>

<style type="text/css">
div.zd{
	overflow:hidden;
}
div.zd h5{
	border-width:0 0 1px;
	padding:0;
	margin:0;
	height:30px;
	line-height:30px;
	cursor:pointer;
}
</style>
<%
/** modified by hejwa in 20110719 多OP改造--收藏夹功能 end**/
%>
<wtc:service name="sIndexFuncSel" outnum="7" routerKey="region" routerValue="<%=regionCode%>">
	<wtc:param value="<%=workNo%>"/>
</wtc:service>
<wtc:array id="result" scope="end" />
 
<%@ include file="dispatch.jsp" %>	
<ul>
<%
	String wselClsStr = "";
	String yselClsStr = "";
	String cselClsStr = "";
	String cateFlag   = "";
	if(retCode.equals("000000")){
	  if(result.length>0){
		for(int i=0;i<result.length;i++){
			String tmp = getLink(result[i][5],result[i][2],result[i][0],session,request,result[i][1]);
			//out.println("<li><a href='javascript:L(\""+result[i][5]+"\",\""+result[i][0]+"\",\""+result[i][1]+"\",\""+tmp+"\",\""+result[i][3]+"\");'>"+"["+result[i][0]+"]"+result[i][1]+"</a></li>");
			/** modified by hejwa in 20110719 多OP改造--收藏夹功能 begin**/
			//根据标志位判断类别
			cateFlag = result[i][6].trim();
			if(cateFlag.equals("0")){
				wselClsStr += "<li><a href='javascript:L(\""+result[i][5]+"\",\""+result[i][0]+"\",\""+result[i][1]+"\",\""+tmp+"\",\""+result[i][3]+"\");'>"+"["+result[i][0]+"]"+result[i][1]+"</a></li>"+"\n";
			}else if(cateFlag.equals("1")){
				yselClsStr += "<li><a href='javascript:L(\""+result[i][5]+"\",\""+result[i][0]+"\",\""+result[i][1]+"\",\""+tmp+"\",\""+result[i][3]+"\");'>"+"["+result[i][0]+"]"+result[i][1]+"</a></li>"+"\n";
			}else if(cateFlag.equals("2")){
				cselClsStr += "<li><a href='javascript:L(\""+result[i][5]+"\",\""+result[i][0]+"\",\""+result[i][1]+"\",\""+tmp+"\",\""+result[i][3]+"\");'>"+"["+result[i][0]+"]"+result[i][1]+"</a></li>"+"\n";
			}
		}
	}
}%>

			<div class="zd">
				<h5 style="margin-top:0px;font-size:12px;color:#003488;font-weight:bold;" onclick="toggle(this.parentNode,this)"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_dleft.gif"  />业务类</h5>
				<%=yselClsStr%>
			</div>
			<div class="zd">
				<h5 style="margin-top:0px;font-size:12px;color:#003488;font-weight:bold;" onclick="toggle(this.parentNode,this)"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_dleft.gif" />查询类</h5>
				<%=cselClsStr%>
			</div>
			<div class="zd">
				<h5 style="margin-top:0px;font-size:12px;color:#003488;font-weight:bold;" onclick="toggle(this.parentNode,this)"><img src="<%=request.getContextPath()%>/nresources/<%=cssPath%>/images/arrow_dleft.gif" />未分类</h5>
				<%=wselClsStr%>
			</div>

	<%
	/** modified by hejwa in 20110719 多OP改造--收藏夹功能 end**/
	%>
</ul>
