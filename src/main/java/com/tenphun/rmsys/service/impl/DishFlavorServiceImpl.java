package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.entity.DishFlavor;
import com.tenphun.rmsys.mapper.DishFlavorMapper;
import com.tenphun.rmsys.service.DishFlavorService;
import org.springframework.stereotype.Service;

@Service
public class DishFlavorServiceImpl extends ServiceImpl<DishFlavorMapper, DishFlavor> implements DishFlavorService {
}
