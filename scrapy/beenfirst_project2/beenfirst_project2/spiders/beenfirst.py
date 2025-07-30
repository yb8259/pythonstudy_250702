import scrapy
from beenfirst_project2.items import BeenfirstProject2Item



class BeenfirstSpider(scrapy.Spider):
    name = "beenfirst"
    allowed_domains = ["davelee-fun.github.io"]
    start_urls = ["https://davelee-fun.github.io"]

    def parse(self, response):
        item = BeenfirstProject2Item()
        item["title"]=response.css("h1.sitetitle::text").get()
        description = response.xpath("//p[@class='lead']/text()").get()
        item["description"]=description
        yield item # item을 넣는것을 실행해라
