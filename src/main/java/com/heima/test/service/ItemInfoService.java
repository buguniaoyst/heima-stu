package com.heima.test.service;

import com.heima.test.domain.ItemInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ItemInfoService  extends  BaseService<ItemInfo>{
    public ItemInfo selectItemInfoByPrimaryId(Integer itemId) {
        return this.getMapper().selectByPrimaryKey(itemId);
    }
}
