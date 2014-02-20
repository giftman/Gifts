--how can we create many many accounts
Account = {
    balance = 0,
    withdraw = function (self,v)
        self.balance = self.balance -v
    end
}
function Account:deposit (v)
    self.balance = self.balance + v
end

function Account:new (o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

a = Account:new{balance = 1000}
--a:deposit(100.00)
a.withdraw(a,1200)
print(a.balance)
