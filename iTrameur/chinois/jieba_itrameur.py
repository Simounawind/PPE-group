import jieba
import matplotlib.pyplot as plt
from imageio import imread
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator
import numpy as np
from PIL import Image
# module for Chinese word segmentation

text_from_file = open('dumps.txt', 'r', encoding='UTF-8')
data = text_from_file.read()
jieba.load_userdict("userdict.txt")
seg_list = jieba.cut(data, cut_all=False)

fW = open('corpus-ch_itrameur.txt', 'w', encoding='UTF-8')
fW.write(' '.join(seg_list))
# put result in new file, separate tokens by space

text_from_file.close()
fW.close()
