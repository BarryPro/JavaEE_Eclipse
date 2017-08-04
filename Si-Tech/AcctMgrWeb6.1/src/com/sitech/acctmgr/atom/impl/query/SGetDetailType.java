package com.sitech.acctmgr.atom.impl.query;

import com.sitech.acctmgr.atom.domains.detail.QueryTypeEntity;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeInDTO;
import com.sitech.acctmgr.atom.dto.query.SGetDetailTypeOutDTO;
import com.sitech.acctmgr.atom.entity.inter.IDetailDisplayer;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.query.IGetDetailType;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

import java.util.ArrayList;
import java.util.List;

@ParamTypes({
        @ParamType(m = "query", c = SGetDetailTypeInDTO.class, oc = SGetDetailTypeOutDTO.class)
})
public class SGetDetailType extends AcctMgrBaseService implements IGetDetailType {

    protected IDetailDisplayer detailDisplayer;

    @Override
    public OutDTO query(InDTO inParam) {

        SGetDetailTypeInDTO inDto = (SGetDetailTypeInDTO) inParam;
        log.debug("inDto=" + inDto.getMbean());

        String detailType = inDto.getDetailType();
        String queryType = inDto.getQueryType();

        List<QueryTypeEntity> outList = new ArrayList<>();

        QueryTypeEntity qte = null;
        if (detailType == null || detailType.trim().length() == 0) { //安保部详单查询录入时，不传此参数
            qte = new QueryTypeEntity();
            qte.setQueryType("25");
            qte.setQueryName("全部");

        } else { //SP一键退费时，使用此部分
            qte = new QueryTypeEntity();
            qte.setQueryType("0");
            qte.setQueryName("全部");

            queryType = null;
        }

        List<QueryTypeEntity> result = detailDisplayer.getDetailTypeList(queryType, detailType);

        outList.add(qte); //index=0
        outList.addAll(result);

        SGetDetailTypeOutDTO outDto = new SGetDetailTypeOutDTO();
        outDto.setDetailTypeList(outList);
        return outDto;
    }

    public IDetailDisplayer getDetailDisplayer() {
        return detailDisplayer;
    }

    public void setDetailDisplayer(IDetailDisplayer detailDisplayer) {
        this.detailDisplayer = detailDisplayer;
    }
}
