--a simple object and for use 
Account = {
    balance = 0,
    withdraw = function(self,v)
        self.balance = self.balance -v 
    end
}

function Account:deposit (v)
    self.balance = self.balance + v
end

Account.withdraw(Account,1000.00)
Account:deposit(100.00)
print(Account.balance)
