class Bank
{
    private int balance = 1000;

    private readonly object locker = new object();

    public void Withdraw(object amount)
    {
        Monitor.Enter(locker);

        try
        {
            int money = (int)amount;

            if (balance >= money)
            {
                Console.WriteLine($"{Thread.CurrentThread.Name} withdraws {money}");

                Thread.Sleep(1000);

                balance -= money;

                Console.WriteLine($"Balance: {balance}");
            }
            else
            {
                Console.WriteLine($"{Thread.CurrentThread.Name}: insufficient funds");
            }
        }
        finally
        {
            Monitor.Exit(locker);
        }
    }
}

class Program
{
    static void Main()
    {
        Bank bank = new Bank();

        Thread atm1 = new Thread(bank.Withdraw);
        Thread atm2 = new Thread(bank.Withdraw);
        Thread atm3 = new Thread(bank.Withdraw);

        atm1.Name = "ATM 1";
        atm2.Name = "ATM 2";
        atm3.Name = "ATM 3";

        atm1.Start(500);
        atm2.Start(700);
        atm3.Start(300);
    }
}s