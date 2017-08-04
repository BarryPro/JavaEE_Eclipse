package com.sitech.acctmgr.atom.impl.volume;

import static org.apache.commons.collections.MapUtils.safeAddToMap;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sitech.acctmgr.atom.busi.volume.inter.IVolume;
import com.sitech.acctmgr.atom.domains.volume.PsIdListEntity;
import com.sitech.acctmgr.atom.dto.volume.SGrpVolumeDataSynInDTO;
import com.sitech.acctmgr.atom.dto.volume.SGrpVolumeDataSynOutDTO;
import com.sitech.acctmgr.common.AcctMgrBaseService;
import com.sitech.acctmgr.inter.volume.IGrpVolume;
import com.sitech.jcf.core.exception.BusiException;
import com.sitech.jcfx.anno.ParamType;
import com.sitech.jcfx.anno.ParamTypes;
import com.sitech.jcfx.dt.in.InDTO;
import com.sitech.jcfx.dt.out.OutDTO;

/**
 * Created by wangyla on 2017/3/28.
 */
@ParamTypes({
        @ParamType(c = SGrpVolumeDataSynInDTO.class, m = "dataSyn", oc = SGrpVolumeDataSynOutDTO.class, srvName = "com_sitech_acctmgr_inter_volume_IGrpVolumeSvc_dataSyn")
})
public class SGrpVolume extends AcctMgrBaseService implements IGrpVolume {

    private IVolume volume;

    public OutDTO dataSyn(InDTO inParam) {
        SGrpVolumeDataSynInDTO inDTO = (SGrpVolumeDataSynInDTO) inParam;

        log.debug("inDto=" + inDTO.getMbean());

        String opCode = inDTO.getOpCode();
        Map<String, Object> inMap = new HashMap<>();
        String orderId = inDTO.getOrderId();

        if (opCode.equals("10011")) {
            safeAddToMap(inMap, "ORDER_ID", inDTO.getOrderId());
            safeAddToMap(inMap, "PS_ID", inDTO.getPsId());
            safeAddToMap(inMap, "UNIT_ID_NO", inDTO.getUnitIdNo());
            safeAddToMap(inMap, "GOODS_ID", inDTO.getGoodsId());
            safeAddToMap(inMap, "BUYS_DATE", inDTO.getBuysDate());
            safeAddToMap(inMap, "BUYS_NUMBER", inDTO.getBuysNumber());
            safeAddToMap(inMap, "BUYS_SIZE", inDTO.getBuysSize());
            safeAddToMap(inMap, "BUYS_PRICE", inDTO.getBuysPrice());
            safeAddToMap(inMap, "SALE_EFF_DATE", inDTO.getSaleEffDate());
            safeAddToMap(inMap, "SALE_EXP_DATE", inDTO.getSaleExpDate());
            volume.saveBuyOpr(inMap);

        } else if (opCode.equals("10012")) {
            volume.saveBuyOprHis(orderId);
            volume.deleteBuyOprByOrderId(orderId);

        } else if (opCode.equals("10013")) {
            safeAddToMap(inMap, "ORDER_ID", inDTO.getOrderId());
            safeAddToMap(inMap, "UNIT_ID_NO", inDTO.getUnitIdNo());
            safeAddToMap(inMap, "GOODS_ID", inDTO.getGoodsId());
            safeAddToMap(inMap, "SALE_DATE", inDTO.getSaleDate());
            safeAddToMap(inMap, "SALE_SIZE", inDTO.getSaleSize());
            safeAddToMap(inMap, "SALE_PRICE", inDTO.getSalePrice());
            safeAddToMap(inMap, "BUYER_ID", inDTO.getBuyerId());
            safeAddToMap(inMap, "BUYER_PHONE", inDTO.getBuyerPhone());
            safeAddToMap(inMap, "USE_EFF_DATE", inDTO.getUseEffDate());
            safeAddToMap(inMap, "USE_EXP_DATE", inDTO.getUseExpDate());
            
            List<PsIdListEntity> psidList = inDTO.getPsIdList();
            if (psidList != null && psidList.size() > 0) {
                for (PsIdListEntity psIdListEntity : psidList) {
                    safeAddToMap(inMap, "PS_ID", psIdListEntity.getPsId());
                    safeAddToMap(inMap, "SALE_NUMBER", psIdListEntity.getSaleNumber());
                    volume.saveSaleInfo(inMap);
                }
            }

        } else if (opCode.equals("10014")) {
            volume.saveSaleInfoHis(orderId);
            volume.deleteSaleInfoByOrderId(orderId);

        } else {
            throw new BusiException("", "传入的OP_CODE不正确");
        }

        SGrpVolumeDataSynOutDTO outDTO = new SGrpVolumeDataSynOutDTO();

        return outDTO;
    }

    public IVolume getVolume() {
        return volume;
    }

    public void setVolume(IVolume volume) {
        this.volume = volume;
    }
}
