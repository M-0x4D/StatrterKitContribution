<?php

declare(strict_types=1);
namespace Plugin\TecSeeProductsRentalBooking;
// define('TESTCONST','TEST CONST');

use JTL\Events\Dispatcher;
use JTL\Link\LinkInterface;
use JTL\Plugin\Bootstrapper;
use JTL\Smarty\JTLSmarty;
use MvcCore\Jtl\Controllers\Frontend\Test;
use MvcCore\Jtl\Services\InstallService;
use Plugin\TecSeeProductsRentalBooking\AdminRender;
use MvcCore\Jtl\Services\RoutesService;
use MvcCore\Jtl\Support\Debug\Debugger;
use Shop;
require_once __DIR__ .'/vendor/autoload.php';
/**
 * Class Bootstrap
 * @package Plugin\TecSeeProductsRentalBooking
 */
class Bootstrap extends Bootstrapper
{
    private $routesService;

    /**
     * @inheritdoc
     */
    public function boot(Dispatcher $dispatcher)
    {
        parent::boot($dispatcher);
        $this->routesService = new RoutesService();
        if (Shop::isFrontend()) {
            
            $dispatcher->listen('shop.hook.' . \HOOK_IO_HANDLE_REQUEST, fn (array $args) => $this->routesService->frontend_endpoints(), 1);
            $dispatcher->listen('shop.hook.' . \HOOK_SMARTY_FETCH_TEMPLATE, fn () => $this->routesService->frontend_executions(), 1);
        } else {
            
            $dispatcher->listen('shop.hook.' . \HOOK_IO_HANDLE_REQUEST_ADMIN, fn (array $args) => $this->routesService->backend_endpoints(), 1);
        }
    }

    /**
     * @inheritdoc
     */
    public function installed()
    {
        parent::installed();

        $withInstall = new InstallService();
        $withInstall->install();
    }

    /**
     * 
     * it's migrate database tables when plugin 
     */

    public function enabled()
    {
    }

    public function uninstalled(bool $deleteData = false)
    {
        if ($deleteData === true) {
            $deleteTables = new InstallService();
            $deleteTables->unInstall();
        }
    }
    /**
     * 
     * writing adminpanel routes for retriving data from database
     * @return string
     */
    public function renderAdminMenuTab(string $template, int $menuID, JTLSmarty $smarty): string
    {
        $this->routesService->backend_executions();

        $render = new AdminRender($this->getPlugin());
        return $render->renderPage($template,  $smarty);
    }

    /**
     * writing frontend routes for retrieving data from database
     */
    public function prepareFrontend(LinkInterface $link, JTLSmarty $smarty): bool
    {
        $this->routesService->frontend_process();
        parent::prepareFrontend($link, $smarty);

       
        return true;
    }

    /**
     * writing frontend routes for retrieving data from database
     */
    // public function prepareFrontend(LinkInterface $link, JTLSmarty $smarty): bool
    // {
    //     $this->routesService->frontend_process();
    //     parent::prepareFrontend($link, $smarty);
    //     return true;
    // }
}
