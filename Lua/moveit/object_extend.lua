--the scripts on the book not work...the self.limit have no value... but change the self to Specialaccount it can run.
--don't know why...and Multiple Inheritance also omitted
Account = {balance = 0}

function Account:new (o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function Account:deposit (v)
    self.balance = self.balance + v
    print "Account deposit \n"
end

function Account:withdraw (v)
    if v >self.balance then error "insufficient funds" end
    self.balance = self.balance - v
end

SpecialAccount = Account:new ()
s = SpecialAccount:new {limit = 1000.00}
function SpecialAccount:getLimit ()
    print(SpecialAccount.limit)
    return SpecialAccount.limit or 0
end
function SpecialAccount:withdraw (v)
    if v-self.balance >= self:getLimit() then
        error "insufficient funds"
    end
    self.balance = self.balance -v
end

function s:getLimit()
    print "s's Limit"
    return s.balance * 0.10
end
--s:deposit(100.00)
print(s.getLimit())
