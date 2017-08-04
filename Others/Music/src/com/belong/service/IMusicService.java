package com.belong.service;

import java.util.List;

import com.belong.vo.Music;

public interface IMusicService {
	public boolean addMusic(Music music);
	public boolean delMusic(Music music);
	public List<Music> queryMusic();
}
