/**
 * wanghfa 20100602 bossά���ı�����ô˷���������statement��ҳ��form����
 * wanghfa 20100607 �����˱����ʽ�Ľ���
 **/

function select_boss(statement)
{
	if(statement)
	{
		with(statement) 
		{
			//alert("rpt_type.value is "+rpt_type.value);
			if(rpt_type.value==2)
			{
			    document.all("rpt_format").options.length=8;
			    document.all("rpt_format").options[0].text='��ϸ';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='����С��';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='����С��';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='���ѷ�ʽС��';
			    document.all("rpt_format").options[3].value='00010';
			    document.all("rpt_format").options[4].text='��ϸ+����С��';
			    document.all("rpt_format").options[4].value='11000';
			    document.all("rpt_format").options[5].text='��ϸ+����С��';
			    document.all("rpt_format").options[5].value='10100';
			    document.all("rpt_format").options[6].text='��ϸ+���ѷ�ʽС��';
			    document.all("rpt_format").options[6].value='10010';
			    document.all("rpt_format").options[7].text='��ϸ+����С��+����С��+���ѷ�ʽС��';
			    document.all("rpt_format").options[7].value='11110';

				hTableName.value="rpt003";
				hParams1.value= "prc_1625_pt003_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==12)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr001_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==19)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1676_001Prn_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
			else if(rpt_type.value==26)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr008_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==29)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1247_pr0010_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
			else if(rpt_type.value==46)
			{
				hTableName.value="rcd002";
				hParams1.value= "prc_1249_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==49)
			{
				hTableName.value="rPo006";
				hParams1.value= "prc_1610_po006_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==50)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1251_2_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==134)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_3459_pt134_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==147)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_rpt147_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			}
			else if(rpt_type.value==149)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1625_rpt149_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
				else if(rpt_type.value==178)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt4141_1_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
				else if(rpt_type.value==177)
			{
					hTableName.value="rbo006";
				hParams1.value= "prc_1625_pt4141_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
			//xl add for 1362 ����
			else if(rpt_type.value==324)
			{   
				//alert("1");
				/*document.all("rpt_format").options.length=8;
			    document.all("rpt_format").options[0].text='��ϸ';
			    document.all("rpt_format").options[0].value='10000';
			    document.all("rpt_format").options[1].text='����С��';
			    document.all("rpt_format").options[1].value='01000';
			    document.all("rpt_format").options[2].text='����С��';
			    document.all("rpt_format").options[2].value='00100';
			    document.all("rpt_format").options[3].text='���ѷ�ʽС��';
			    document.all("rpt_format").options[3].value='00010';
			    document.all("rpt_format").options[4].text='��ϸ+����С��';
			    document.all("rpt_format").options[4].value='11000';
			    document.all("rpt_format").options[5].text='��ϸ+����С��';
			    document.all("rpt_format").options[5].value='10100';
			    document.all("rpt_format").options[6].text='��ϸ+���ѷ�ʽС��';
			    document.all("rpt_format").options[6].value='10010';
			    document.all("rpt_format").options[7].text='��ϸ+����С��+����С��+���ѷ�ʽС��';
			    document.all("rpt_format").options[7].value='11110';*/
				/*hTableName.value="rbo006";
				hParams1.value= "prc_1625_rpt1362_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";*/
				//hParams1.value= "prc_1625_rpt1362_upg('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"','"+rpt_format.value+"'";
				hTableName.value="rfo006";
				hParams1.value= "DBCUSTADM.prc_1362_rpt_upg('T','"+groupId.value+"',' ',' ','"+workNo.value+"','"+begin_login.value+"|"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";
			 }
			 //
			 else if(rpt_type.value==348)
			{
				//alert("test is ");
				hTableName.value="DBCUSTADM.RCR7722";
				hParams1.value= "DBCUSTADM.PRC_CARD_TJJ_UPG('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
			 //xl add for huxl ����ͻ�
			else if(rpt_type.value==360)
			{
				//alert("test is ");
				hTableName.value="rfo006";
				hParams1.value= "DBCUSTADM.PRC_2147_ZQ_RPT('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
			//
			else if(rpt_type.value==371)
			{
				//alert("test is ");
				hTableName.value="rbo006";
				hParams1.value= "DBCUSTADM.PRC_2147_e_inv_billing('"+workNo.value+"','"+groupId.value+"','"+begin_login.value+"','"+end_login.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_boss.jsp";}
		}
	}
}
