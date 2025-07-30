# Define your item pipelines here
#
# Don't forget to add your pipeline to the ITEM_PIPELINES setting
# See: https://docs.scrapy.org/en/latest/topics/item-pipeline.html


# useful for handling different item types with a single interface
from itemadapter import ItemAdapter
from scrapy.exceptions import DropItem


class BeenfirstProject2Pipeline:
    def process_item(self, item, spider):
        if item["description"] : # item 에 이 값이 있다면
            item["description"] = item["description"].strip() #전처리후 
            return item # item 한테 넣어라
        else :
            raise DropItem("Missing description in %s" % item) # 그렇지 않으면 버려라!  %s는 형식지정자(string:문자열)
        
