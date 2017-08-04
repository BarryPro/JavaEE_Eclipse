package com.belong.dao;

import java.util.List;

import com.belong.vo.Music;

public interface IMusicDAO {
	public boolean addMusic(Music music);
	public boolean delMusic(Music music);
	public List<Music> queryMusic();
}
