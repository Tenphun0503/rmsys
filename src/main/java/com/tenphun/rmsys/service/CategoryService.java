package com.tenphun.rmsys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.tenphun.rmsys.entity.Category;

public interface CategoryService extends IService<Category> {
    public void remove(Long id);
}
