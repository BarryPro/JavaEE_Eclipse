<%@page contentType="text/html;charset=GBK"%>
    <%
     String login_no = (String)session.getAttribute("workNo");
    %>
<script language="JavaScript">

var jid;
var jwchats = new Array();
var SITENAME='10.110.0.125';
var DEFAULTRESOURCE='jwchat';

/* check if user want's to register new
 * account and things */    
function loginJwchat() { 

  jid = "<%=login_no%>" + "@" + SITENAME + "/";
  jid += DEFAULTRESOURCE;

  jwchats[jid] = window.open('http://10.110.0.125:35000/hljim/jwchat.html?jid='+unicode(jid),'_blank','width=180,height=390,resizable=yes');
  return false;
}
//鍔犲瘑jid
function unicode(s){ 
   var len=s.length; 
   var rs=""; 
   for(var i=0;i<len;i++){ 
          var k=s.substring(i,i+1); 
          rs+= (i==0?"":",")+s.charCodeAt(i); 
   } 
   return rs; 
} 
    </script>

    <div>
       <table width="99%" border="0" cellpadding="0" cellspacing="0" class="list" >
          <tr>
            <td>
            	<img src="../../../nresources/default/images/arrow_link_blue.gif" alt="dot" width="3" height="5"> <a href="javascript:void(0);" onclick="return loginJwchat();">登录及时通讯</a>
            </td>
          </tr>
       </table>	
    </div>
    <script>
    	 $("#wait7").hide(); 
    </script> 