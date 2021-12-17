const routes = [
  {
    path: '/',
    component: () => import('layouts/MainLayout.vue'),
    children: [
      {path: '', component: () => import('pages/Dashboard.vue'), 
      meta: {
        requiresAuth: true
      }
      },
      {path: '/Swap', component: () => import('pages/Swap.vue')},
      

      // Not completed yet
      // {path: '/Taskboard', component: () => import('pages/TaskBoard.vue')},
    ]
  },

  // Always leave this as last one,
  // but you can also remove it
  
  {
    path: '/login',
    component: () => import('pages/login.vue')
  },
  {
    path: '/signup',
    component: () => import('pages/signup.vue')
  },
  
]

export default routes
