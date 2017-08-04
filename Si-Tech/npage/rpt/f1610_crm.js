//** yuanqs 100601 crm维护的报表调用此方法,参数statement是页面form对象
function select_crm(statement)
{
	if(statement)
	{
		with(statement)
		{
			if(rpt_type.value==3)
			{
				hTableName.value="rso006";
				hParams1.value= "prc_1610_so006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==4)
			{
				hTableName.value="rco006";
				hParams1.value= "prc_1610_co006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==5)
			{
				hTableName.value="rfo006";
				hParams1.value= "prc_1610_fo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==6)
			{
				hTableName.value="rto006";
				hParams1.value= "prc_1610_to006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			
			else if(rpt_type.value==8)
			{
				hTableName.value="rjo006";
				hParams1.value= "prc_1610_jo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==9)
			{
				hTableName.value="ryo006";
				hParams1.value= "prc_1610_yo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==10)
			{
				hTableName.value="rgo006";
				hParams1.value= "prc_1610_go006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==11)
			{
				hTableName.value="rto006";
				hParams1.value= "prc_1610_to006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==12)
			{
				hTableName.value="rro006";
				hParams1.value= "prc_1610_ro006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==13)
			{
				hTableName.value="rao006";
				hParams1.value= "prc_1610_ao006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==14)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1246_pr006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==15)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1246_pr006_a_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==16)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1610_zo006_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==17)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1610_zo006_a_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==19)
			{
				hTableName.value="rjo005";
				hParams1.value= "prc_1247_pr006_upg('0','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==20)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1247_pr009_upg('0','"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==25)
			{
				hTableName.value="rct003";
				hParams1.value= "prc_1610_prepayMark_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==26)
			{
				hTableName.value="rpt003";
				hParams1.value= "prc_1397_pt067_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==27)
			{
				hTableName.value="rjo005";
				hParams1.value= "PRC_1444_CX021_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==28)
			{
				hTableName.value="rpt003";
				hParams1.value= "PRC_1444_CX028_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==29)
			{
				hTableName.value="rbr001";
				hParams1.value= "prc_1610_4a00_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==30)
			{
				hTableName.value="rpt003";
				hParams1.value= "PRC_1610_makeUpSim_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==31)
			{
				hTableName.value="rpo006";
				hParams1.value= "prc_1610_wpaybc_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==32)
			{
				hTableName.value="rpo006";
				hParams1.value= "prc_1610_ZO100('"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			
			else if(rpt_type.value==33)
			{
				hTableName.value="rcr001";
				hParams1.value= "prc_1610_pt33_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			 else if(rpt_type.value==35)
			{
				hTableName.value="rco005";
				hParams1.value= "prc_1610_pt35_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"','"+function_code.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==36)
			{
				hTableName.value="dbo005";
				hParams1.value= "prc_1610_newsale_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==41)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_1610_gnvip_upg('"+workNo.value+"','"+login_no.value+"','"+begin_time.value+"','"+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}
			else if(rpt_type.value==45)
			{
				hTableName.value="rbo006";
				hParams1.value= "prc_2145_45_upg('"
					+workNo.value+"','"
					+login_no.value+"','"
					+begin_time.value+"','"
					+end_time.value+"'";
				action = "print_rpt_crm.jsp";
			}			
		}
	}
}
