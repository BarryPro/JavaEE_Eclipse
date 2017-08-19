package org.crazyit.linkgame.utils;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.imageio.ImageIO;


/**
 * ͼƬ������
 * 
 * @author yangenxiong yangenxiong2009@gmail.com
 * @version  1.0
 * <br/>��վ: <a href="http://www.crazyit.org">���Java����</a>
 * <br>Copyright (C), 2009-2010, yangenxiong
 * <br>This program is protected by copyright laws.
 */
public class ImageUtil {

	/**
	 * ���ڻ�ȡĳ���ļ������������ͼƬ
	 * 
	 * @param folder
	 *            Ŀ���ļ���
	 * @param subfix
	 *            ͼƬ��׺
	 * @return ����ͼƬ���ϣ���Ԫ��ΪBufferedImage
	 * @throws IOException
	 *             �����ȡ����ͼƬ���߶�ȡͼƬ�����׳��쳣
	 */
	public static List<BufferedImage> getImages(File folder, String subfix)
			throws IOException {
		// ��Ŀ���ļ����л�ȡ�ļ��б�
		File[] items = folder.listFiles();
		// ����������϶���
		List<BufferedImage> result = new ArrayList<BufferedImage>();
		// ���ļ��б���б���
		for (File file : items) {
			// ������ļ�����ָ�����ļ���׺, ��ӵ��������
			if (file.getName().endsWith(subfix)) {
				result.add(ImageIO.read(file));
			}
		}
		return result;
	}

	/**
	 * �����sourceImages�ļ����л�ȡsize��ͼƬ
	 * 
	 * @param sourceImages
	 *            ԴͼƬ�Ķ��󼯺�
	 * @param size
	 *            ��Ҫ��ȡ��ͼƬ����
	 * @return ���������ȡ��ͼƬ����
	 */
	public static List<BufferedImage> getRandomImages(
			List<BufferedImage> sourceImages, int size) {
		// ����һ�������������
		Random random = new Random();
		// �����������
		List<BufferedImage> result = new ArrayList<BufferedImage>();
		for (int i = 0; i < size; i++) {
			try {
				// �����ȡһ�����֣�����0��������ԴͼƬ���ϵ�size
				int index = random.nextInt(sourceImages.size());
				// ��ԴͼƬ�����л�ȡ��ͼƬ����
				BufferedImage image = sourceImages.get(index);
				// ��ӵ��������
				result.add(image);
			} catch (IndexOutOfBoundsException e) {
				// ��ԴͼƬ���ϵ�sizeΪ0ʱ���ᷢ������Խ�磬ֱ�ӷ��ؽ����
				return result;
			}

		}
		return result;
	}

	/**
	 * �������sourceImages
	 * 
	 * @param sourceImages
	 *            ��Ҫ�����ҵ�ͼƬ����
	 * @return
	 */
	public static List<BufferedImage> randomImages(
			List<BufferedImage> sourceImages) {
		// ����һ�������������
		Random random = new Random();
		// ����һ��������ֵļ���
		List<Integer> numbers = new ArrayList<Integer>();
		// ��ȡһ������, ������һЩ�����ҵ�����
		for (int i = 0; i < sourceImages.size(); i++) {
			// �������һ�����֣���Χ��0������sourceImage��size, ����0������size
			Integer temp = random.nextInt(sourceImages.size());
			// Ϊ��ȷ������û���ظ�������������Ѿ��ڴ�����ֵļ����У������ٻ�ȡһ������
			if (!numbers.contains(temp)) {
				// ������ֵļ�����û�и����������Ӽ�����
				numbers.add(temp);
			} else {
				// �������Ѿ������ڼ����У�i - 1ִ��ѭ��
				i--;
				continue;
			}
		}
		// ����һ���������
		List<BufferedImage> result = new ArrayList<BufferedImage>();
		// ��ԴͼƬ���Ͻ��б���
		for (int i = 0; i < sourceImages.size(); i++) {
			// �����ּ����л�ȡ�Ѿ������ҵ�������ԴͼƬ���ϻ�ȡ���������ֵ
			result.add(sourceImages.get(numbers.get(i)));
		}
		return result;
	}

	/**
	 * �Ӳ���folder�ж�ȡsize�ţ�����sizeΪ��Ϸ������������Ա�2����
	 * 
	 * @param folder
	 *            ��Ҫ�����ҵ�ͼƬ����
	 * @param size
	 *            ��Ҫ�����ҵ�ͼƬ����
	 * @return
	 */
	public static List<BufferedImage> getPlayImages(File folder, int size) {
		if (size % 2 != 0) {// ���������2���������׳�����ʱ�쳣
			throw new GameException("image size error");
		}
		try {
			// �ȴ�Ŀ���ļ����л�ȡȫ����.gif��β��ͼƬ
			List<BufferedImage> images = getImages(folder, ".gif");
			// �ٴ����е�ͼƬ�������ȡsize��һ������
			List<BufferedImage> playImages = getRandomImages(images, size / 2);
			// ���������ͼƬ���ϴ��ң�����������һ��ͼƬ����
			List<BufferedImage> randomImages = randomImages(playImages);
			// ǰ���ͼƬ���Ϻ�����ҵ�ͼƬ����ɽ����
			playImages.addAll(randomImages);
			return playImages;
		} catch (IOException e) {
			// ��ȡͼƬ�����׳��Զ��������ʱ�쳣
			throw new GameException("read images error");
		}
	}

	public static BufferedImage getImage(String imagePath) {
		try {
			// ʹ��ImageIO��ȡͼƬ
			return ImageIO.read(new File(imagePath));
		} catch (IOException e) {
			// ��ȡͼƬ�����쳣���׳�GameException
			throw new GameException("read image error");
		}
	}
}
