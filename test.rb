require 'csv' # basic functionality to csv
require 'daru' # 
require 'distribution' # all ways of normalization
require 'nmatrix' # 
require 'pp' # pretty-print
require 'mysql' #  DB-table -> csv
require 'statsample' # more functionality to math (correlations & etc)
#requre 'kakaya-to super poleznaya hernya'


#read from CSV with first string as headers string
data = CSV.read("titanic.csv", headers:true)

# 1 - count all men and women on a board
a = data['Sex'].count('male')
puts "Men: #{a}"
b = data['Sex'].count - a
puts "Women: #{b}"

# 2 - count share of survivors
c = data['Survived'].count.to_f
d = data['Survived'].count('1').to_f
e = ((d/c) * 100).round(2)
puts "Share of survivors: #{e}"

# 3 - count share of passengers in the first class 
f = data['Pclass'].count('1').to_f
g = ((f/c)*100).round(2)
puts "Share of passengers in the first class: #{g}"

# 4 - count mean and median for ages on Titanic
b = Daru::Vector[data['Age'].compact!.map {|x| x.to_i}]
puts "Mean age: #{b.mean.round(2)}"
puts "Median age: #{b.median.round(2)}"

# 5 - count pearson correlation for sibsp & parch
sib_v = Daru::Vector[data['SibSp'].map(&:to_i)]
parch_v = Daru::Vector[data['Parch'].map(&:to_i)]
puts "Pearson correlation: #{Statsample::Bivariate.correlation(sib_v,parch_v)}"

# 6 - count the most popular female first name on Titanic
all_females = data['Name'].delete_if {|i|  !(/(Miss.*|\(.*\))/.match(i))}  # delele all elements with men
female_names = []
all_females.each {|a| female_names << /(?<=\()\w+|(?<=Miss. )\w+/.match(a)} # get everything after ( & Miss.
female_names = female_names.compact # get out of here nil
						   .map! {|i| i.to_s} # MatchData -> String
						   .inject(Hash.new(0)){ |h,i| h[i] += 1; h } # create hash of mode
						   .max{ |a,b| a[1] <=> b[1] } # take most popular
puts "The most popular name: #{female_names}"


# mysql = Mysql.init()
# mysql.connect(host='127.0.0.1', user='root', passwd='', db='office')

# Z = N[[4, 5, 0], 
#       [1, 9, 3],              
#       [5, 1, 1],
#       [3, 3, 3], 
#       [9, 9, 9],
#       [4, 7, 1]]
# n = NMatrix.eye(3)
# m = NMatrix.eye(3)
# pp n
# pp m
# pp nm = n.vconcat(m)

# a = CSV.generate do |csv|
#   csv << ["id", "user_id", "login", "phone_password", "created_at","updated_at","intermediary_active","crm_id","account_group_id", "status","uid","repl_in","repl_out"]
#   mysql.query("SELECT * FROM real_accounts").each { |row| csv << row }
# end

# CSV.open("/Users/n00bie/study/machine_learning/ruby/tester.csv", "wb") do |csv|
#   csv << ["id", "user_id", "login", "phone_password", "created_at","updated_at","intermediary_active","crm_id","account_group_id", "status","uid","repl_in","repl_out"]
#   mysql.query("SELECT * FROM real_accounts").each { |row| csv << row }
# end
#  data = CSV.read("tester.csv")

# pp data.first(10)

# # print data
# #CSV.foreach("titanic.csv") {|row| print  "#{row} \n"}
# x = 10
# y = 1
# z = 2
# rng = Distribution::Normal.rng(1, 10 )
# puts rng.call
# puts rng.call
# p pdf = Distribution::Normal.pdf(x)

# values = []
# 4.times {|i| values << rng.call}
# # # p log = Distribution::Gamma.mean
# puts n = NMatrix.new([2, 2], values)
# puts mean = n.mean(0)
# puts std =  n.std(0)
# puts semi_n = n - mean
# puts n_new = semi_n / mean

# semi_n = n.each_row.map do |row|
#   row / x.йmax
# end

# pp a = Daru::Vector.new_with_size(1000, &rng)
# # print data.take(3)
# # print data[:10]
# pp n_new
# X = np.random.normal(loc=1, scale=10, size=(1000, 50))

# p timeseries = Daru::Vector.new(1000.times.map {rng.call})
