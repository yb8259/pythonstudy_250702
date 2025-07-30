# Define here the models for your scraped items
#
# See documentation in:
# https://docs.scrapy.org/en/latest/topics/items.html

import scrapy


class Been7ProjectItem(scrapy.Item):
    # define the fields for your item here like:
    # name = scrapy.Field()

    title = scrapy.Field()
    link = scrapy.Field()
    category = scrapy.Field()
    name = scrapy.Field()
    date = scrapy.Field()
    