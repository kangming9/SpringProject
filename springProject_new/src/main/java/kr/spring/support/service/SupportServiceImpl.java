package kr.spring.support.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.gift.dao.GiftMapper;
import kr.spring.support.dao.SupportMapper;

@Service
@Transactional
public class SupportServiceImpl implements SupportService{

	@Autowired
	private SupportMapper supportMapper;
	
	

}
