<?php

namespace common\models;

use common\models\ValueHelpers;
use Yii;
use yii\web\Controller;
use yii\helpers\Url;

class PermissionHelpers {

    public static function requireUpgradeTo($user_type_name) {

        if (!ValueHelpers::userTypeMatch($user_type_name)) {

            return Yii::$app->getResponse()->redirect(Url::to(['upgrade/index']));
        }
    }

    public static function requireUserStatus($status_name) {

        return ValueHelpers::statusMatch($status_name) ? true : false;
    }

    public static function requireUserRole($role_name) {

        return ValueHelpers::roleMatch($role_name) ? true : false;
    }

    public static function requireMinimumRole($role_name, $userId = null) {

        if (ValueHelpers::getRoleValue($role_name)) {

            switch ($userId) {

                case $userId == null :

                    $userRoleValue = ValueHelpers::getUsersRoleValue();

                    break;

                case $userId != null :

                    $userRoleValue = ValueHelpers::getUsersRoleValue($userId);

                    break;
            } //end of switch

            return $userRoleValue >= ValueHelpers::getRoleValue($role_name) ? true : false;
        } else {

            return false;
        }
    }

    public static function userMustBeOwner($model_name, $model_id) {

        $connection = \Yii::$app->db;
        $userid = Yii::$app->user->identity->id;
        $sql = "SELECT id FROM $model_name WHERE user_id=:userid AND id=:model_id";
        $command = $connection->createCommand($sql);
        $command->bindValue(":userid", $userid);
        $command->bindValue(":model_id", $model_id);

        if ($result = $command->queryOne()) {

            return true;
        } else {

            return false;
        }
    }

}
