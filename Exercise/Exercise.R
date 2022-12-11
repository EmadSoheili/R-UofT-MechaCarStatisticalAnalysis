x <- 3
x <- 5
numlist <- c(0,1,2,3,4,5,6,7,8,9)

demo_table <- read.csv(file='demo.csv', check.names = F, stringsAsFactors = F)
library(jsonlite)

demo_table2 <- fromJSON(txt = 'demo.json')

demo_table[3,'Year']

filter_table <- demo_table2[demo_table2$price >10000,]

filter_table2 <- subset(demo_table2, price>10000 & drive=='4wd' & 'clean'%in%title_status)

num_rows <- 1:nrow(demo_table2)
sample_rows <- sample(num_rows, 10)
demo_table2[sample_rows,]

sample_table <- demo_table2[sample(1:nrow(demo_table2),10),]

demo_table <- demo_table %>% mutate(Milage_per_Year=Total_Miles/(2020-Year), IsActive=T)

demo_table3 <- read.csv('demo2.csv', check.names = F, stringsAsFactors = F)

long_table <- gather(demo_table3, key='Metric', value='Score', buying_price:popularity)

wide_table <- spread(long_table, key='Metric', value='Score')

all_equal(wide_table, demo_table3)

wide_table <-  wide_table[,colnames(demo_table3)]

all_equal(wide_table, demo_table3)


head(mpg)

plt <- ggplot(mpg, aes(x=class))
plt + geom_bar()


mpg_summary <- group_by(mpg, manufacturer) %>% summarize(Vehicle_Count=n(), .groups='keep')

ggplot(mpg_summary, aes(x=manufacturer, y=Vehicle_Count)) +
  geom_col() +
  xlab('Manufacturing Company') +
  ylab('Number of Vehicle in Dataset') +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

mpg_summary2 <- subset(mpg, manufacturer == 'toyota') %>% group_by(cyl) %>% summarize(Mean_Hwy = mean(hwy), .groups = 'keep')
ggplot(mpg_summary2, aes(x = cyl, y = Mean_Hwy)) +
  geom_line() +
  scale_x_discrete(limits = c(4,6,8)) +
  scale_y_continuous(breaks = c(16:30))

ggplot(mpg, aes(x = displ, y = cty, color = class, shape = drv, size = hwy, alpha = displ)) +
  geom_point() +
  labs(x = 'Engine Size (L)', y = ' City Fuel-Efficiency (MPG)', color = 'Vehicle Class')
  
mpg_summary3 = group_by(mpg, class, year) %>% summarize(Mean_Hwy = mean(hwy), .groups = 'keep')
ggplot(mpg_summary3, aes(x=class, y=year, fill=Mean_Hwy)) +
  geom_tile() +
  labs(x='Vehicle Class', y='Vehicle Year', fill='Mean Highway (MPG)') +
  theme(axis.text.x=element_text(angle=90, hjust=1, vjust=0.5))

ggplot(mpg,aes(x=manufacturer,y=hwy)) +
  geom_boxplot() +
  theme(axis.text.x=element_text(angle=45,hjust=1)) +
  geom_point()

mpg_long <- gather(mpg, key='MPG_Type', value='Rating', c(cty,hwy))
ggplot(mpg_long, aes(x=manufacturer, y=Rating, color=MPG_Type)) +
  geom_boxplot() +
  theme(axis.text.x=element_text(angle=45, hjust=1))

ggplot(mpg_long, aes(x=manufacturer, y=Rating, color=MPG_Type)) +
  geom_boxplot() +
  theme(axis.text.x=element_text(angle=45, hjust=1), legend.position='none') +
  xlab('manufacturer') +
  facet_wrap(vars(MPG_Type))
  
ggplot(mtcars, aes(x=wt)) +
  geom_density()

shapiro.test(mtcars$wt)

pop_table <- read.csv('used_car_data.csv', check.names = F, stringsAsFactors = F)

ggplot(pop_table, aes(x=log10(Miles_Driven))) +
  geom_density()

sample_table <- sample_n(pop_table, 50)
ggplot(sample_table, aes(x=log10(Miles_Driven))) +
  geom_density()

t.test(log10(sample_table$Miles_Driven), mu=mean(log10(pop_table$Miles_Driven)))

sample_table2 <- sample_n(pop_table, 50)

t.test(log10(sample_table$Miles_Driven), log10(sample_table2$Miles_Driven))

mpg_data <- read.csv('mpg_modified.csv')
mpg_1999 <- filter(mpg_data, year==1999)
mpg_2008 <- filter(mpg_data, year==2008)

t.test(mpg_1999$hwy, mpg_2008$hwy, paired = T)

mtcars_filt <- mtcars[, c('hp','cyl')]
mtcars_filt$cyl <- factor(mtcars_filt$cyl)
summary(aov(hp ~ cyl, data=mtcars_filt))

ggplot(mtcars, aes(x=hp, y=qsec)) +
  geom_point()

cor(mtcars$hp, mtcars$qsec)

used_cars_matrix <- as.matrix(pop_table[,c('Selling_Price', 'Present_Price', 'Miles_Driven')])
cor(used_cars_matrix)

lm(qsec~hp, mtcars)
summary(lm(qsec~hp, mtcars))

model <- lm(qsec~hp, mtcars)
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)']
ggplot(mtcars, aes(x=hp, y=qsec)) +
  geom_point() +
  geom_line(aes(y=yvals), color='red')

lm(qsec~mpg+disp+drat+wt+hp, mtcars)
summary(lm(qsec~mpg+disp+drat+wt+hp, mtcars))
summary(lm(qsec~wt+hp, mtcars))

tbl <- table(mpg$class, mpg$year)
chisq.test(tbl)
