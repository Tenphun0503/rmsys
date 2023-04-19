package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.entity.Category;
import com.tenphun.rmsys.mapper.CategoryMapper;
import com.tenphun.rmsys.service.CategoryService;
import org.springframework.stereotype.Service;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {
}
