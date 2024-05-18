// 常量路由
export const constRoutes = [
    {
        //     登录&注册
        path: '/login',
        component: () => import('@/views/login_signup/index.vue'),
        name: 'login',
        meta: {
            title: '登录注册',
            hidden: true,
        }
    },
    {
        //     404
        path: '/404',
        component: () => import('@/views/404/index.vue'),
        name: '404',
        meta: {
            title: "404",
            hidden: true,
            icon: 'Avatar',
        }
    },
    {
        // layout一级组件
        path: '/',
        component: () => import('@/views/layout/index.vue'),
        name: 'layout',
        redirect: '/home',
        meta: {
            hidden: false,
        },
        children: [
            {
                path: '/home',
                component: () => import('@/views/home/index.vue'),
                name: 'home',
                meta: {
                    title: '首页',
                    hidden: false,
                    icon: 'HomeFilled'
                }
            },
        ]
    },
    {
        // 个人中心
        path: '/userCenter',
        component: () => import("@/views/userCenter/index.vue"),
        name: 'UserCenter',
        meta: {
            title: "个人中心",
            hidden: true,
        }
    }
]
// 异步路由
export const asyncRoutes = [
    {
        // 权限管理
        path:'/acl',
        component:()=>import('@/views/layout/index.vue'),
        name:'Acl',
        meta:{
            title:'权限管理',
            hidden:false,
            icon:'Lock'
        },
        redirect: '/acl/user',
        children:[
            {
                path: '/acl/user',
                component: () => import('@/views/acl/user/index.vue'),
                name: 'User',
                meta: {
                    title: '用户管理',
                    hidden: false,
                    icon: 'User'
                }
            }
        ]
    },
    {
        // 学生心理健康状态
        path: '/collegeMentalState',
        component: () => import('@/views/layout/index.vue'),
        name: 'CollegeMentalState',
        meta: {
            title: '心理健康状态',
            hidden: false,
            icon: 'Grid'
        },
        redirect: '/home',
        children: [
            {
                // 大学生端
                path: '/collegeMentalState/college',
                component: () => import('@/views/collegeMentalState/college/index.vue'),
                name: 'MentalStateCollege',
                meta: {
                    title: '量表测试结果',
                    hidden: false,
                    icon: 'Avatar'
                },
            },
            {
                // 心理咨询师端
                path: '/collegeMentalState/counselor',
                component: () => import('@/views/collegeMentalState/counselor/index.vue'),
                name: 'MentalStateCounselor',
                meta: {
                    title: '学生量表测试结果',
                    hidden: false,
                    icon: 'Avatar'
                },
            }
        ]
    },
    {
        // 心理辅导记录
        path: '/counseling',
        component: () => import('@/views/layout/index.vue'),
        name: 'Counseling',
        meta: {
            title: '心理辅导',
            hidden: false,
            icon: 'Document'
        },
        redirect: '/counseling/prebook',
        children: [
            {
                // 心理辅导预约
                path: '/counseling/prebook',
                component: () => import('@/views/counselingRecords/prebook/index.vue'),
                name: 'Prebook',
                meta: {
                    title: '心理辅导预约',
                    hidden: false,
                    icon: 'Clock'
                }
            },
            {
                // 心理咨询师端
                path: '/counseling/counselor',
                component: () => import('@/views/counselingRecords/counselor/index.vue'),
                name: 'RecordsCounselor',
                meta: {
                    title: '心理辅导记录',
                    hidden: false,
                    icon: 'View'
                }
            },
            {
                // 大学生端
                path: '/counseling/college',
                component: () => import('@/views/counselingRecords/college/index.vue'),
                name: 'RecordsCollege',
                meta: {
                    title: '查看辅导记录',
                    hidden: false,
                    icon: 'View'
                }
            }
        ]
    },
    {
        // 心理量表测试
        path: '/mentalScaleTest',
        component: () => import('@/views/layout/index.vue'),
        name: 'MentalScaleTest',
        redirect: '/mentalScaleTest/phq9',
        meta: {
            title: '心理量表测试',
            hidden: false,
            icon: 'List'
        },
        children: [
            {
                // phq9量表
                path: '/mentalScaleTest/phq9',
                component: () => import('@/views/mentalScaleTest/phq9/index.vue'),
                name: 'Phq9',
                meta: {
                    title: 'phq9量表',
                    hidden: false,
                    icon: 'Tickets'
                }
            },
            {
                // 中国大学生心理健康筛查量表
                path: '/mentalScaleTest/csmhss',
                component: () => import('@/views/mentalScaleTest/csmhss/index.vue'),
                name: 'Csmhss',
                meta: {
                    title: '中国大学生心理健康筛查量表',
                    hidden: false,
                    icon: 'Tickets'
                }
            },
            {
                // sas量表
                path: '/mentalScaleTest/sas',
                component: () => import('@/views/mentalScaleTest/sas/index.vue'),
                name: 'Sas',
                meta: {
                    title: 'SAS',
                    hidden: false,
                    icon: 'Tickets'
                }
            },
            {
                // sds量表
                path: '/mentalScaleTest/sds',
                component: () => import('@/views/mentalScaleTest/sds/index.vue'),
                name: 'Sds',
                meta: {
                    title: 'SDS',
                    hidden: false,
                    icon: 'Tickets'
                }
            }
        ]
    },

]

//任意路由
export const anyRoute = {
    // 任意路由
    path: '/:pathMatch(.*)*',
    redirect: '/404',
    name: 'Any',
    meta: {
        title: '任意路由',
        hidden: true,
        icon: 'Avatar',
    }
}