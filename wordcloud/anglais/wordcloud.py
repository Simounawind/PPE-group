import matplotlib.pyplot as plt
from imageio import imread
from wordcloud import WordCloud, STOPWORDS, ImageColorGenerator
from PIL import Image

text_from_file = open('dumps.txt', 'r', encoding='UTF-8')
data = text_from_file.read()        

fW = open('dumps-en.txt', 'w', encoding='UTF-8')
word_space = ' '.join(seg_list)
fW.write(' '.join(seg_list))        
# put result in new file, separate tokens by space

text_from_file.close()
fW.close()

STOPWORDS = set((
        "En", "ch", "text", "ais", "svg", "Fran", "text", "page", "text page", "b", "v2", "in", "to", "the", "on", "of", "its", "and", "all", "day"
    ))

img = imread('main.png')
img = np.array(Image.open('main.png'))

my_wordcloud = WordCloud(
    scale=6,
    background_color='white',
    mask=img,
    max_words = 200,
    stopwords = STOPWORDS,
    font_path = 'alima.ttf', 
    max_font_size = 150,
    random_state=50, 
    ).generate(word_space)

image_colors = ImageColorGenerator(img)
my_wordcloud.recolor(color_func=image_colors)
plt.imshow(my_wordcloud)
plt.axis('off')
plt.show()
my_wordcloud.to_file('result.jpg')
