<?php
/**
 *
 */

namespace Accountancy\Features\AccountManagement;

use Accountancy\Entity\Account;
use Accountancy\Entity\Collection\CurrencyCollection;
use Accountancy\Entity\User;
use Accountancy\Features\FeatureException;

/**
 * Class CreateAccount
 *
 * @package Accountancy\Features\AccountManagement
 */
class CreateAccount
{
    /**
     * @var User
     */
    protected $user;

    /**
     * @var string
     */
    protected $accountName;

    /**
     * @var int
     */
    protected $currencyId;

    /**
     * @var CurrencyCollection
     */
    protected $currencies;

    /**
     * @param string $accountName
     *
     * @return CreateAccount
     */
    public function setAccountName($accountName)
    {
        $this->accountName = $accountName;

        return $this;
    }

    /**
     * @param int $currencyId
     *
     * @return CreateAccount
     */
    public function setCurrencyId($currencyId)
    {
        $this->currencyId = $currencyId;

        return $this;
    }

    /**
     * @param \Accountancy\Entity\User $user
     *
     * @return CreateAccount
     */
    public function setUser(User $user)
    {
        $this->user = $user;

        return $this;
    }

    /**
     * @param \Accountancy\Entity\CurrencyCollection $currencies
     *
     * @return $this
     */
    public function setCurrencies(CurrencyCollection $currencies)
    {
        $this->currencies = $currencies;

        return $this;
    }

    /**
     * @throws \Accountancy\Features\FeatureException
     */
    public function run()
    {
        $account = new Account();

        if (trim($this->accountName) == '') {
            throw new FeatureException("Name of Account can not be empty");
        }

        if ($this->user->getAccounts()->findAccountByName($this->accountName) instanceof Account) {
            throw new FeatureException(sprintf("Account '%s' already exists", $this->accountName));
        }

        $account->setName($this->accountName);

        if (!$this->currencies->hasCurrency($this->currencyId)) {
            throw new FeatureException("Invalid currency provided");
        }

        $account->setCurrencyId($this->currencyId);

        $this->user->getAccounts()->addAccount($account);
    }
}
