import scrapy


class Been1SpiderSpider(scrapy.Spider):
    name = "been1_spider"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        pass
