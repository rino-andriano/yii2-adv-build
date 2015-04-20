<?php

namespace frontend\controllers;

use Yii;
use common\models\UserProfile;
use yii\web\Controller;
use yii\web\NotFoundHttpException;
use yii\filters\VerbFilter;
use common\models\PermissionHelpers;
use common\models\RecordHelpers;

/**
 * UserProfileController implements the CRUD actions for UserProfile model.
 */
class UserProfileController extends Controller {

    public function behaviors() {
        return [
            'access' => [
                'class' => \yii\filters\AccessControl::className(),
                'only' => ['index', 'view', 'create', 'update', 'delete'],
                'rules' => [
                    [
                        'actions' => ['index', 'view', 'create', 'update', 'delete'],
                        'allow' => true,
                        'roles' => ['@'],
                        //require an 'Active' UserRole
                        'matchCallback' => function ($rule, $action) {
                            return PermissionHelpers::requireUserStatus('Active');
                        }
                    ],
                ],
            ],
            'verbs' => [
                'class' => VerbFilter::className(),
                'actions' => [
                    'delete' => ['post'],
                ],
            ],
        ];
    }

    /**
     * Lists all UserProfile models.
     * @return mixed
     */
    public function actionIndex() {
        if ($already_exists = RecordHelpers::userHas('user_profile')) {
            return $this->render('view', [
                        'model' => $this->findModel($already_exists),
            ]);
        } else {
            return $this->redirect(['create']);
        }
    }

    /**
     * Displays a single UserProfile model.
     * @param integer $id
     * @return mixed
     */
    public function actionView() {
        if ($already_exists = RecordHelpers::userHas('user_profile')) {
            return $this->render('view', [
                        'model' => $this->findModel($already_exists),
            ]);
        } else {
            return $this->redirect(['create']);
        }
    }

    /**
     * Creates a new UserProfile model.
     * If creation is successful, the browser will be redirected to the 'view' page.
     * @return mixed
     */
    public function actionCreate() {
        $model = new UserProfile;
        $model->user_id = Yii::$app->user->identity->id;

        if ($already_exists = RecordHelpers::userHas('user_profile')) {
            return $this->render('view', [
                        'model' => $this->findModel($already_exists),
            ]);
        } elseif ($model->load(Yii::$app->request->post()) && $model->save()) {
            return $this->redirect(['view']);
        } else {
            return $this->render('create', [
                        'model' => $model,
            ]);
        }
    }

    /**
     * Updates an existing UserProfile model.
     * If update is successful, the browser will be redirected to the 'view' page.
     * @param integer $id
     * @return mixed
     */
    public function actionUpdate($id) {
        /*
         * Demo di RequireUpgradeTo (UserType)
         * se decommentato consente l'update del profilo solo agli utenti 'paid'
         */
        // PermissionHelpers::requireUpgradeTo('Paid');

        if ($model = UserProfile::find()->where(['user_id' =>
                    Yii::$app->user->identity->id])->one()) {
            if ($model->load(Yii::$app->request->post()) && $model->save()) {
                return $this->redirect(['view']);
            } else {
                return $this->render('update', [
                            'model' => $model,
                ]);
            }
        } else {
            throw new NotFoundHttpException('No Such UserProfile.');
        }
    }

    /**
     * Deletes an existing UserProfile model.
     * If deletion is successful, the browser will be redirected to the 'index' page.
     * @param integer $id
     * @return mixed
     */
    public function actionDelete($id) {
        $model = UserProfile::find()->where([
                    'user_id' => Yii::$app->user->identity->id
                ])->one();

        $this->findModel($model->id)->delete();

        return $this->redirect(['site/index']);
    }

    /**
     * Finds the UserProfile model based on its primary key value.
     * If the model is not found, a 404 HTTP exception will be thrown.
     * @param integer $id
     * @return UserProfile the loaded model
     * @throws NotFoundHttpException if the model cannot be found
     */
    protected function findModel($id) {
        if (($model = UserProfile::findOne($id)) !== null) {
            return $model;
        } else {
            throw new NotFoundHttpException(Yii::t('app', 'The requested page does not exist.'));
        }
    }

}
