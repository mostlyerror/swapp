import React from 'react'

// const people = [
//   {
//     name: 'Jane Cooper',
//     title: 'Regional Paradigm Technician',
//     role: 'Admin',
//     email: 'jane.cooper@example.com',
//   },
//   {
//     name: 'Cody Fisher',
//     title: 'Product Directives Officer',
//     role: 'Owner',
//     email: 'cody.fisher@example.com',
//   },
// ]

const List = (props) => {
  return (
    <div className="flex flex-col">
      <div className="overflow-x-auto ">
        <div className="overflow-hidden border border-gray-900 rounded-xl">
          <table className="min-w-full divide-y divide-gray-200">
            <thead className="bg-gray-50">
              <tr>
                <th
                  scope="col"
                  className="px-2 py-3 text-left text-base md:text-lg font-medium text-gray-800 font-semibold tracking-wide"
                >
                  Name
                </th>
                <th
                  scope="col"
                  className="px-2 py-3 text-left text-base md:text-lg font-medium text-gray-800 font-semibold tracking-wide"
                >
                  Email
                </th>
                <th
                  scope="col"
                  className="px-2 py-3 text-left text-base md:text-lg font-medium text-gray-800 font-semibold tracking-wide"
                >
                  Roles
                </th>
                <th scope="col" className="relative px-2 py-3">
                  <span className="sr-only">Edit</span>
                </th>
              </tr>
            </thead>
            <tbody>
              {props.users.map((user, personIdx) => (
                <tr
                  key={user.email}
                  className={personIdx % 2 === 0 ? 'bg-white' : 'bg-gray-50'}
                >
                  <td className="px-2 py-4 whitespace-nowrap text-base md:text-lg font-medium text-gray-900">
                    {user.name}
                  </td>
                  <td className="px-2 py-4 whitespace-nowrap text-base md:text-lg text-gray-500">
                    {user.email}
                  </td>
                  <td className="px-2 py-4 whitespace-nowrap text-base md:text-lg text-gray-500">
                    <div className="flex gap-1">
                      {user.roles.map((role, roleIdx) => {
                        return (
                          <span
                            key={roleIdx}
                            className="p-1 bg-admin-blue text-black text-sm tracking-wide rounded"
                          >
                            {role}
                          </span>
                        )
                      })}
                    </div>
                  </td>
                  <td className="px-2 py-4 whitespace-nowrap text-right text-base md:text-lg font-medium">
                    <a
                      href="#"
                      className="text-indigo-600 hover:text-indigo-900"
                    >
                      Edit
                    </a>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
}

export default List
