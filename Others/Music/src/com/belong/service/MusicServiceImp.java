package com.belong.service;

import java.util.List;

import com.belong.dao.IMusicDAO;
import com.belong.dao.MusicDAOImp;
import com.belong.vo.Music;

public class MusicServiceImp implements IMusicService {
	private IMusicDAO dao = new MusicDAOImp();
	@Override
	public boolean addMusic(Music music) {
		// TODO Auto-generated method stub
		return dao.addMusic(music);
	}

	@Override
	public boolean delMusic(Music music) {
		// TODO Auto-generated method stub
		return dao.delMusic(music);
	}

	@Override
	public List<Music> queryMusic() {
		// TODO Auto-generated method stub
		return dao.queryMusic();
	}

}
