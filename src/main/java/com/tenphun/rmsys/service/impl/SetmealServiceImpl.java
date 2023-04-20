package com.tenphun.rmsys.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.tenphun.rmsys.entity.Setmeal;
import com.tenphun.rmsys.mapper.SetmealMapper;
import com.tenphun.rmsys.service.SetmealService;
import org.springframework.stereotype.Service;

@Service
public class SetmealServiceImpl extends ServiceImpl<SetmealMapper, Setmeal> implements SetmealService {
}
