package com.sitech.acctmgr.atom.impl.acctmng;

import java.util.List;

import com.sitech.acctmgr.atom.busi.invoice.inter.IPrintDataXML;
import com.sitech.acctmgr.atom.domains.collection.CollectionDispEntity;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionOrderPrintInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionOrderPrintOutDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionOrderQueryInDTO;
import com.sitech.acctmgr.atom.dto.acctmng.SCollectionOrderQueryOutDTO;
import com.sitech.acctmgr.atom.entity.inter.ICollection;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.acctmng.ICollectionOrder;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2016/7/5.
 */
@ParamTypes({
        @ParamType(c = SCollectionOrderQueryInDTO.class, m = "query", oc = SCollectionOrderQueryOutDTO.class),
        @ParamType(c = SCollectionOrderPrintInDTO.class, m = "print", oc = SCollectionOrderPrintOutDTO.class)
})
public class SCollectionOrder extends AcctMgrBaseService implements ICollectionOrder {
    private ICollection collection;
    private IPrintDataXML printDataXML;

    @Override
    public OutDTO query(InDTO inParam) {

        SCollectionOrderQueryInDTO inDTO = (SCollectionOrderQueryInDTO) inParam;
        log.info("inDTO=" + inDTO.getMbean());

        List<CollectionDispEntity> outList = collection.getCollectionOrderList(inDTO.getDisGroupId(), inDTO.getBillCycle(), inDTO.getBeginBankCode(),
                inDTO.getEndBankCode(), inDTO.getBeginPrintNo(), inDTO.getEndPrintNo(), inDTO.getProvinceId(), false);

        SCollectionOrderQueryOutDTO outDTO = new SCollectionOrderQueryOutDTO();
        outDTO.setOutList(outList);
        outDTO.setCount(outList.size());

        log.debug("outDto=" + outDTO.toJson());

        return outDTO;
    }

    public ICollection getCollection() {
        return collection;
    }

    public void setCollection(ICollection collection) {
        this.collection = collection;
    }

    public IPrintDataXML getPrintDataXML() {
        return printDataXML;
    }

    public void setPrintDataXML(IPrintDataXML printDataXML) {
        this.printDataXML = printDataXML;
    }

}
