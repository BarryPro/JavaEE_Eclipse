<!--div id="signal" class="s0">ǿ��0</div-->
<!--div id="signal" class="s1">ǿ��1</div-->
<!--div id="signal" class="s2">ǿ��2</div-->
<!--div id="signal" class="s3">ǿ��3</div-->
<!--div id="signal" class="s4">ǿ��4</div-->
<div id="signal" class="s5">ǿ��5</div>
<div id="imdiv">
	<a href="javascript:void(0);" onclick="return loginJwchat();" class="im">��ʱ��Ϣϵͳ</a>
	<a href="javascript:void(0);" onclick="return loginbbs();" class="bbs">BBSϵͳ</a>
</div>
<%	
    String localURL = com.sitech.crmpd.core.wtc.context.Config.getValue( com.sitech.crmpd.core.wtc.context.Config.WEBLOGIC_1);
	if (localURL != null && localURL.length() > 7){
		localURL = localURL.substring(5, localURL.length() - 6);
	}
	 String urlNew = com.sitech.crmpd.core.wtc.context.Config.getValue( com.sitech.crmpd.core.wtc.context.Config.WEBLOGIC_1);
	 int urlNew_tmp = 0;
   if(urlNew!=null)
   {
   	urlNew_tmp = urlNew.indexOf(":")+1;   	
   	urlNew =urlNew.substring(urlNew_tmp,urlNew.length());
   	
   	urlNew_tmp = urlNew.indexOf(":")+1;
		urlNew =urlNew.substring(urlNew_tmp,urlNew.length());
   }
   %>
<div id="footPanel">
	   <ul>
	      <li>�û�����<%=session.getAttribute("workName")%></li>
	      <li>���ţ�<%=session.getAttribute("workNo")%></li>
	      <li>Ӫҵ����<%=lastInfo[0][7]%></li>
	      <li>��������<%=localURL%>:<%=urlNew%></li>
	      <li><a onclick="netspeedtest();" href="#">�ٶȲ��Թ���</a></li>
	   </ul>
</div>

<!-- for bbs begin -->
<form id="loginHljbbs" method='post' action='' target='_blank' style="display:none">
    <input type="hidden" name="username" value="<%=workNo%>"/>
    <input type="hidden" name="password" value="" />
    <input type="hidden" name="ck" value="no" />
</form>
<script type="text/javascript">
   function loginbbs(url){
      var form = document.getElementById('loginHljbbs');
          form.action='http://10.110.0.125:35000/hljbbs/LoginPost.htm';
          form.submit();
   }
</script> 
<!-- for bbs end -->
<!-- for im begion -->
<script type="text/javascript">
var jid;
var jwchats = new Array();
var SITENAME='10.110.0.125';
var DEFAULTRESOURCE='jwchat';
function loginJwchat() { 
  jid = "<%=login_no%>" + "@" + SITENAME + "/";
  jid += DEFAULTRESOURCE;

  jwchats[jid] = window.open('http://10.110.0.125:35000/hljim/jwchat.html?jid='+unicode(jid),'_blank','width=180,height=390,resizable=yes');
  return false;
}

function unicode(s){ 
   var len=s.length; 
   var rs=""; 
   for(var i=0;i<len;i++){ 
          var k=s.substring(i,i+1); 
          rs+= (i==0?"":",")+s.charCodeAt(i); 
   } 
   return rs; 
} 
function netspeedtest(){
	window.showModalDialog('../login/networkspeed.jsp','','');
}
</script>
<!-- for im end -->