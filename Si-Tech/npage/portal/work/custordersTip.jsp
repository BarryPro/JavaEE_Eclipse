<%@ page contentType="text/html;charset=GB2312"%>
<%@ taglib uri="/WEB-INF/wtc.tld" prefix="wtc" %>

<div>
   <table width="99%" border="0" cellpadding="0" cellspacing="0" class="list" >
      <tr>
        <td>
        	<img src="../../../nresources/default/images/arrow_link_blue.gif" alt="dot" width="3" height="5"> <a href="javascript:void(0);" onclick="return loginQuery();">�쳣������ѯ</a>
        </td>
      </tr>
   </table>	
</div>	

<script>
	function loginQuery() {   
	  parent.L("1","q099","�쳣������ѯ","portal/work/custordersTipQuery.jsp","000");
}
	 $("#wait9").hide(); 
</script> 