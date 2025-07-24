import scrapy


class BeenfirstSpider(scrapy.Spider):
    name = "beenfirst"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io/"]

    def parse(self, response):
        pass
