<table width="100%" border="0" cellspacing="4" cellpadding="1">
  <TR bgcolor="#F0FAFF"> 
    <td bgcolor="#F0FAFF" align="center" >
      <input type="button" name="_submitButton" value="�� ��" onclick="saveData();return false">
      <input type="reset" name="_resetButton" value="ȡ ��">
      <input type="button" name="_closeButton" value="�� ��" onclick="cancelJob()">  
    </td>
  </tr>    
</table>

<script language="javascript">
function hideEvent()
{
   if(self.status!="")
   {
     alert("�����ύ���ݣ����Ժ�");     
	   return false;
   }
}

function cancelJob(){
	if (confirm("�˲���������������������ݲ��رյ�ǰ�������棬ȷ����")) {
		top.window.close();	
	}
}

function saveData()
{    
  if (!submitPage())  //ÿ����ҳ�涼��Ҫ�ṩ�÷���
  {
    return false;
  }  
  
  return true; 
}
</script>